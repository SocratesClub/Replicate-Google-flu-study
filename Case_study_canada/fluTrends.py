import pandas as pd
import numpy
import matplotlib.pylab as plt
import statsmodels.api as sm
import statsmodels.formula.api as smf
import statsmodels.graphics.regressionplots as modelPlot

fluTrends = pd.read_excel('fluTrends.xlsx')
searchTerms = pd.read_excel('searchTerms.xlsx')
for i in range(0,len(searchTerms['Week'])):
	a = searchTerms.iat[i,0]
	a = numpy.datetime64(a[0:a.index(' ')])
	searchTerms.iat[i,0] = a

searchTerms.rename(columns = dict(Week='Date'),inplace=True)

searchTerms.set_index(['Date'],inplace=True)
fluTrends.set_index(['Date'],inplace=True)
fluTrends['Canada'] = fluTrends['Canada'] / max(fluTrends['Canada']) * 100

data = pd.concat([fluTrends['Canada'],searchTerms],axis=1)
data = data.dropna(how='any')


data.head()

model = smf.ols('Canada ~ fever*soreThroat*diarrhea*cough',data=data).fit()
model.summary()

plt.clf()
model.fittedvalues.plot(label='Fitted')
data['Canada'].plot(label='Data')
plt.legend(loc='best')
plt.show() #to show the plot


