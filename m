Return-Path: <linux-tip-commits+bounces-3676-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90636A45EBF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F493BBC3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7A22A7F2;
	Wed, 26 Feb 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XyvkHrx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+UYYkSF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75662236EB;
	Wed, 26 Feb 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572112; cv=none; b=D8IYGCBNC5DdqTNAhiAue/5j7dZv2AmkJX9DyQtO0axsrbWsYEDPpOaZ466TQRROdvC5q+t48FBuOpUq2ZqX4FoyJKYUgvf4lZ7z7e8SGiIc9lobKVC2UwmRViQj4S3ePN4biOKjlah/edbKwZvfm/ltdqWzJOGXPYcOhjWlc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572112; c=relaxed/simple;
	bh=BT8K5l3Gc0LjHSPTCNw5pJaT+FqpeHRxPp5uwsfLDq0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uHUQiwz4Ej0CruJzGVgqx74wBxY+cJrWkAUPkb3rUOFprReoPXY655LkoaC9FBSSVlBiiROVtVIGwvijX0RRS/tncAKWwy3zFrPsXWzlBtlmNotx6w8KLzTNoPN9IfoV+AZ/T7CBefAP+rSactrSgS6YKeJUdtR1e9Y/9pjInfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XyvkHrx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+UYYkSF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odFvKC9+fHFTR6P0kwvI5EJWKJcU+JhCiYyjC8juUsQ=;
	b=2XyvkHrxQJwIjss7zzCw1ScZ2x8xhC6uH+r73bqUE2sSxIzlanrBTYqp/KpuJVaTyg4xuj
	JwjT3BaSMlESZSfXgi+lvr2vGVVJ4CaoPT1mVRQ83+B6EsQgOHXfPo41K/IOQ8z0OQj+3A
	lWpOJKKXuG+YeU4cQ6mVp7Iub0k/8pybiLC2Rtc+A8UJGWYNYl8RQfusNF1cF7nH7q3w/K
	O/N+wEQWT84H4uEtDRcFvf1sDmxyu2KVFGDlX55UIVlKj59EY9v/U7XP78YO+Nx8cnNWcc
	lBU9PtcfcQbqBZMlv0vTHVv6JgoCjiHXn2OjqSPsWDUFw7in3vTyHVKcwb3qPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572109;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odFvKC9+fHFTR6P0kwvI5EJWKJcU+JhCiYyjC8juUsQ=;
	b=g+UYYkSFlNeIwA91vWnpjUqR8k8f5zVUiHCMg0VT3v04qe72Og063INjhX9Ac0wSEEdli9
	+LMx3V+AsPVznjBQ==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] selftests/x86/xstate: Enumerate and name xstate components
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-4-chang.seok.bae@intel.com>
References: <20250226010731.2456-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210841.10177.812082949263917644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     3fcb4d61465613aee76ebd5d86b488778657dda7
Gitweb:        https://git.kernel.org/tip/3fcb4d61465613aee76ebd5d86b488778657dda7
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:23 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:28 +01:00

selftests/x86/xstate: Enumerate and name xstate components

After moving essential helpers from amx.c, the code remains neutral
regarding which xstate components it handles. However, explicitly listing
known components helps users identify which features are ready for
testing.

Enumerate xstate components to facilitate identification. Extend struct
xstate_info to include a name field, providing a human-readable
identifier.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-4-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c    |  2 +-
 tools/testing/selftests/x86/xstate.h | 60 +++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 366cfec..cde22f3 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -29,8 +29,6 @@
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
-#define XFEATURE_XTILECFG	17
-#define XFEATURE_XTILEDATA	18
 #define XFEATURE_MASK_XTILECFG	(1 << XFEATURE_XTILECFG)
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 6729ffd..d3461c4 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -9,6 +9,59 @@
 #define XSAVE_HDR_OFFSET	512
 #define XSAVE_HDR_SIZE		64
 
+/*
+ * List of XSAVE features Linux knows about. Copied from
+ * arch/x86/include/asm/fpu/types.h
+ */
+enum xfeature {
+	XFEATURE_FP,
+	XFEATURE_SSE,
+	XFEATURE_YMM,
+	XFEATURE_BNDREGS,
+	XFEATURE_BNDCSR,
+	XFEATURE_OPMASK,
+	XFEATURE_ZMM_Hi256,
+	XFEATURE_Hi16_ZMM,
+	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
+	XFEATURE_PKRU,
+	XFEATURE_PASID,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL_UNUSED,
+	XFEATURE_RSRVD_COMP_13,
+	XFEATURE_RSRVD_COMP_14,
+	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILECFG,
+	XFEATURE_XTILEDATA,
+
+	XFEATURE_MAX,
+};
+
+/* Copied from arch/x86/kernel/fpu/xstate.c */
+static const char *xfeature_names[] =
+{
+	"x87 floating point registers",
+	"SSE registers",
+	"AVX registers",
+	"MPX bounds registers",
+	"MPX CSR",
+	"AVX-512 opmask",
+	"AVX-512 Hi256",
+	"AVX-512 ZMM_Hi256",
+	"Processor Trace (unused)",
+	"Protection Keys User registers",
+	"PASID state",
+	"Control-flow User registers",
+	"Control-flow Kernel registers (unused)",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"AMX Tile config",
+	"AMX Tile data",
+	"unknown xstate feature",
+};
+
 struct xsave_buffer {
 	union {
 		struct {
@@ -58,6 +111,7 @@ static inline uint32_t get_xbuf_size(void)
 }
 
 struct xstate_info {
+	const char *name;
 	uint32_t num;
 	uint32_t mask;
 	uint32_t xbuf_offset;
@@ -69,6 +123,12 @@ static inline struct xstate_info get_xstate_info(uint32_t xfeature_num)
 	struct xstate_info xstate = { };
 	uint32_t eax, ebx, ecx, edx;
 
+	if (xfeature_num >= XFEATURE_MAX) {
+		ksft_print_msg("unknown state\n");
+		return xstate;
+	}
+
+	xstate.name = xfeature_names[xfeature_num];
 	xstate.num  = xfeature_num;
 	xstate.mask = 1 << xfeature_num;
 

