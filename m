Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C963131C4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhBHME5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhBHMBY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E800C06178A;
        Mon,  8 Feb 2021 04:00:44 -0800 (PST)
Date:   Mon, 08 Feb 2021 12:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+G6jSrut1/Vug3A+sj27MDFOKf4FE4+qEg33j0S8O1c=;
        b=puCbVUMhub1EohZ7Ub1w1JUCGEolalHGeHgZa0q2suxqXSdGi6qJa2CmVSkppZW9Rt3rWh
        W5MqWKos9ci535H1cIDBnhpsgA/Jgpjbn8FXoL5elcAhKNKGfshLE6vg8qx+xS6uagSl25
        3qX30TZ3zLMEcBEXsJDekx793yRtSvqhvPyMtYrs6nXqIoHt68fNaid33ESYYmi0K8nIv8
        U55GETbukmbqzWLJ7muY5DyEKC648uS9qvTPardhCTv9nh0ICtekLcrBJTkcNfFMWKkfnh
        2Ev3d5ei1HspoNgzMyXYxao4QMnQA/R3l703/sO5y8SZVZ7RNnn0GOgIeF14FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+G6jSrut1/Vug3A+sj27MDFOKf4FE4+qEg33j0S8O1c=;
        b=nPmInSqRscdW5zfm6SfscqK7lwINo3Q1RQd14QePi4239CGHF98syebijmrEGdF9AY1dCa
        aew6rLn94NKuk3Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call/x86: Add __static_call_return0()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-2-frederic@kernel.org>
References: <20210118141223.123667-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278564044.23325.17664780821329997538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2f44200d3f3d6e6abab4e5529335f7852936f3a1
Gitweb:        https://git.kernel.org/tip/2f44200d3f3d6e6abab4e5529335f7852936f3a1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:55 +01:00

static_call/x86: Add __static_call_return0()

Provide a stub function that return 0 and wire up the static call site
patching to replace the CALL with a single 5 byte instruction that
clears %RAX, the return value register.

The function can be cast to any function pointer type that has a
single %RAX return (including pointers). Also provide a version that
returns an int for convenience. We are clearing the entire %RAX register
in any case, whether the return value is 32 or 64 bits, since %RAX is
always a scratch register anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-2-frederic@kernel.org
---
 arch/x86/kernel/static_call.c | 17 +++++++++++++++--
 include/linux/static_call.h   | 12 ++++++++++++
 kernel/static_call.c          |  5 +++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ca9a380..9442c41 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -11,14 +11,26 @@ enum insn_type {
 	RET = 3,  /* tramp / site cond-tail-call */
 };
 
+/*
+ * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
+ * The REX.W cancels the effect of any data16.
+ */
+static const u8 xor5rax[] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
+
 static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
+	const void *emulate = NULL;
 	int size = CALL_INSN_SIZE;
 	const void *code;
 
 	switch (type) {
 	case CALL:
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		if (func == &__static_call_return0) {
+			emulate = code;
+			code = &xor5rax;
+		}
+
 		break;
 
 	case NOP:
@@ -41,7 +53,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void 
 	if (unlikely(system_state == SYSTEM_BOOTING))
 		return text_poke_early(insn, code, size);
 
-	text_poke_bp(insn, code, size, NULL);
+	text_poke_bp(insn, code, size, emulate);
 }
 
 static void __static_call_validate(void *insn, bool tail)
@@ -54,7 +66,8 @@ static void __static_call_validate(void *insn, bool tail)
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
+		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index a2c0645..bd6735d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -142,6 +142,8 @@ extern void __static_call_update(struct static_call_key *key, void *tramp, void 
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
+extern long __static_call_return0(void);
+
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -206,6 +208,11 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
+static inline long __static_call_return0(void)
+{
+	return 0;
+}
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -222,6 +229,11 @@ struct static_call_key {
 	void *func;
 };
 
+static inline long __static_call_return0(void)
+{
+	return 0;
+}
+
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 84565c2..0bc11b5 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -438,6 +438,11 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+long __static_call_return0(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
