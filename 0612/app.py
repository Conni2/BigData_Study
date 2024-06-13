import streamlit as st


st.set_page_config(
    page_title="LS빅데이터스쿨 2기 대시보드",
    page_icon="🏭",
)

# Streamlit 대시보드
st.title('LS빅데이터 스쿨 제조 데이터 대시보드')
st.balloons()
st.divider() # 구분선
image_url = "https://firebasestorage.googleapis.com/v0/b/ls-storage-e452a.appspot.com/o/%E1%84%83%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%A2%E1%84%89%E1%85%B3%E1%84%90%E1%85%B5%E1%86%BC.gif?alt=media&token=70587460-34c3-4a67-a056-f7a5e6ad8521"

# HTML을 사용하여 이미지 크기 조정
st.markdown(f'<img src="{image_url}" width="700" height="350">', unsafe_allow_html=True)

st.markdown(
    """


## 👨🏻‍🔧 효율적인 제조, 생산관리를 위한 대시보드

오늘날의 제조 환경은 점점 더 복잡해지고 있으며, 경쟁력을 유지하기 위해서는 신속하고 정확한 의사결정이 필수적입니다. 
이러한 요구에 부응하기 위해, 우리는 제조 공정 데이터를 기반으로 하는 최첨단 대시보드를 소개합니다. 
이 대시보드는 데이터를 효율적으로 시각화하고, 원하는 시간대 조회 서비스를 제공하여 제조 공정의 모든 측면을 개선할 수 있도록 설계되었습니다.

#### 핵심 기능 및 이점
--------------------------------

##### 📊 실시간 데이터 시각화 
제조 공정에서 발생하는 다양한 데이터를 수집하여 시각화합니다. 이를 통해 공정 상태를 한눈에 파악할 수 있으며, 빠른 의사결정을 지원합니다.

--------------------------------

##### 📈 효율성 분석 
각 공정 단계의 성능을 분석하여 비효율적인 부분을 식별하고, 최적화 방안을 제시합니다. 이를 통해 자원 낭비를 최소화하고, 생산성을 극대화할 수 있습니다.

--------------------------------

##### 🤖 불량요인 분석 
과거 데이터를 기반으로 미래의 공정 상태를 예측합니다. 예측 분석 기능을 통해 사전에 문제를 예방하고, 공정 안정성을 향상시킬 수 있습니다.

--------------------------------

##### 🗺 맞춤형 대시보드 
사용자의 필요에 맞게 대시보드를 맞춤화할 수 있습니다. 각 사용자에게 가장 유용한 정보를 손쉽게 확인할 수 있도록 합니다.

--------------------------------

##### 🛎 생산 관리 
일자별 및 시간별 데이터 조회 서비스를 제공하여 생산 관리를 보다 효율적으로 수행할 수 있도록 합니다.


            
- [ ] [시간별 데이터 조회](/pages/01_Hour_data.py)
- [ ] [일자별 데이터 조회](/pages/02_Daily_data.py)
- [ ] [제품 품질 예측](/pages/03_Predict_data.py)

"""
)
st.divider()

# 표 넣기
import streamlit as st
import pandas as pd
df = pd.DataFrame({
  'first column': [1, 2, 3, 4],
  'second column': [10, 20, 30, 40]
})

st.write(df)
st.divider()


import streamlit as st
import pandas as pd
import numpy as np

dataframe = pd.DataFrame(
    np.random.randn(10, 20),
    columns=('col %d' % i for i in range(20)))

st.dataframe(dataframe.style.highlight_max(axis=0))
st.divider()

# 차트 넣기
import streamlit as st
import numpy as np
import pandas as pd

chart_data = pd.DataFrame(
     np.random.randn(20, 3),
     columns=['a', 'b', 'c'])

st.line_chart(chart_data)
st.divider()

# 슬라이더 만들기
import streamlit as st
x = st.slider('x')  # 👈 this is a widget
st.write(x, 'squared is', x * x)

st.divider()

# 폼 받기
import streamlit as st
st.text_input("Your name", key="name")

# You can access the value at any point with:
st.session_state.name

#st.divider()

# 사이드 바로 넘기기
import streamlit as st

# Add a selectbox to the sidebar:
add_selectbox = st.sidebar.selectbox(
    'How would you like to be contacted?',
    ('Email', 'Home phone', 'Mobile phone')
)

# Add a slider to the sidebar:
add_slider = st.sidebar.slider(
    'Select a range of values',
    0.0, 100.0, (25.0, 75.0)
)

# st.divider()

# # 대기상태 페이지
# import streamlit as st
# import time

# 'Starting a long computation...'

# # Add a placeholder
# latest_iteration = st.empty()
# bar = st.progress(0)

# for i in range(100):
#   # Update the progress bar with each iteration.
#   latest_iteration.text(f'Iteration {i+1}')
#   bar.progress(i + 1)
#   time.sleep(0.1)

# '...and now we\\'re done!'
