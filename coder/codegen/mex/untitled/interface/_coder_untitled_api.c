/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_untitled_api.c
 *
 * Code generation for function '_coder_untitled_api'
 *
 */

/* Include files */
#include "_coder_untitled_api.h"
#include "rt_nonfinite.h"
#include "untitled.h"
#include "untitled_data.h"

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *inputArg1,
  const char_T *identifier);
static const mxArray *emlrt_marshallOut(const real_T u);

/* Function Definitions */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *inputArg1,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(inputArg1), &thisId);
  emlrtDestroyArray(&inputArg1);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

void untitled_api(const mxArray * const prhs[2], int32_T nlhs, const mxArray
                  *plhs[2])
{
  real_T inputArg1;
  real_T inputArg2;
  real_T outputArg1;
  real_T outputArg2;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  inputArg1 = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "inputArg1");
  inputArg2 = emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "inputArg2");

  /* Invoke the target function */
  untitled(inputArg1, inputArg2, &outputArg1, &outputArg2);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(outputArg1);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(outputArg2);
  }
}

/* End of code generation (_coder_untitled_api.c) */
