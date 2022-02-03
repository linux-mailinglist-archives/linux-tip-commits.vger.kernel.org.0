Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7A4A8667
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Feb 2022 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351393AbiBCOdw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Feb 2022 09:33:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351347AbiBCOdq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:46 -0500
Date:   Thu, 03 Feb 2022 14:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hpkw9TpsOb+gTlEE8A32A6EkG9JeglPlktFwHnluJKA=;
        b=1H7SMSNrpT/PcDpgTOM7TLmNaNMSqpsCKVcguLonmcxQOAeQtW+vw9BH6haZgvHAxuN1yE
        /CSBGRVCEdJSBmLC8dTr2gvgp7xg16jtEmV0b8pCgunLPSlSaH6MQoq+0kVsBQ5f3nFKCQ
        Ih2738g297BbdUCu4r9ENf83+V77A709UuwGmP/BCEYA2UrdyENlaGD/RgPDIhRwbJ2lZt
        bdR2UiqNHrOirN/bubFwkZMgTx7cEKEoEnLAgSlrQ/xdi4FMmrCQ9CDJFOaT+mZXK2ER6u
        GQf7FNQ/gNusSZmTHbqS3ek0AT7Qbm+53Sgntrb4fB58Co/uJV5PpChtRNWRyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Hpkw9TpsOb+gTlEE8A32A6EkG9JeglPlktFwHnluJKA=;
        b=ySPUp1FDFyZpKIOI7r4nTZZaB2VFAoHu7pWhMgT+NP9EXJICLSi6EWOAjGSuYaqqqXJaOf
        0sgkFp8Wl+3eVRAg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Remove arm/mips asm goto compiler
 work-around
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164389882399.16921.14384383010012082538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94c5cf2a0e193afffef8de48ddc42de6df7cac93
Gitweb:        https://git.kernel.org/tip/94c5cf2a0e193afffef8de48ddc42de6df7cac93
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:50 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:36 +01:00

selftests/rseq: Remove arm/mips asm goto compiler work-around

The arm and mips work-around for asm goto size guess issues are not
properly documented, and lack reference to specific compiler versions,
upstream compiler bug tracker entry, and reproducer.

I can only find a loosely documented patch in my original LKML rseq post
refering to gcc < 7 on ARM, but it does not appear to be sufficient to
track the exact issue. Also, I am not sure MIPS really has the same
limitation.

Therefore, remove the work-around until we can properly document this.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20171121141900.18471-17-mathieu.desnoyers@efficios.com/
---
 tools/testing/selftests/rseq/rseq-arm.h  | 37 +-----------------------
 tools/testing/selftests/rseq/rseq-mips.h | 37 +-----------------------
 2 files changed, 74 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index ae476af..64c3a62 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -147,14 +147,11 @@ do {									\
 		teardown						\
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
-
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -198,14 +195,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -221,7 +215,6 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -270,14 +263,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -292,7 +282,6 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 #ifdef RSEQ_COMPARE_TWICE
@@ -328,10 +317,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
@@ -347,7 +334,6 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -398,14 +384,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -422,7 +405,6 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -474,14 +456,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -498,7 +477,6 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -554,14 +532,11 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -582,7 +557,6 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -678,21 +652,16 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -706,7 +675,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -803,21 +771,16 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 0d1d925..878739f 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -154,14 +154,11 @@ do {									\
 		teardown \
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
-
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -203,14 +200,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -226,7 +220,6 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -273,14 +266,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -295,7 +285,6 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 #ifdef RSEQ_COMPARE_TWICE
@@ -331,10 +320,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
@@ -350,7 +337,6 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -399,14 +385,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -423,7 +406,6 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -473,14 +455,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -497,7 +476,6 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -549,14 +527,11 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -577,7 +552,6 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -670,21 +644,16 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -698,7 +667,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -792,21 +760,16 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
