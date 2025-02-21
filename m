Return-Path: <linux-tip-commits+bounces-3574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC3A3F800
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209CB189E6D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC020FABA;
	Fri, 21 Feb 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3c/CtVJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07WDlXTp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50A74BED;
	Fri, 21 Feb 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150390; cv=none; b=X4z6nReZJKWxKozHEfgnlnbJyydhdSKmMqmqK0yx/EtorvqP6HpDRLwPBazJgoSuD7Pt+ZmJPn8LbNQsTgO5h4lMVk/gHo6SDCmxpQGR39RIsYq+Z4qu9yckGzptsqKsKSajk2eaM2iYN0RdWcoFT+KfzwC/Q2xHZUjEu/9ywaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150390; c=relaxed/simple;
	bh=a5SgbGW2cgjTRnSxurqT4hzzhmjJRMHsUlH/MuWEqiE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n4seO0O8vk9eD9INf9qLo4na/RGUZUCJGNeNhOh+zyyFazYQQJkB6sxkxvjjyTTXtwDaIj1vb1s7UEysfskA3zva/YHsoCw4uQbcLpZ42sx91iLeojlCdcMyU2uywfErC4ykI5oRXJ5t39oGMvg3S/DmjTYxnJpC4opyprKbE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3c/CtVJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07WDlXTp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740150387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTwNWjVGEeFKvQmeWGEuWKIWLtZMJV1csi/3Mm1y2aY=;
	b=n3c/CtVJawVR0jZ50K2ko5f/nZ9++1Qmck7vV7tqxWq1jQC2+iTnVCVxHF/lOBKjXzBEmH
	blvWMYV7lKZpiTvT1CXhhzGt2H2wjwEV82pCRTZOlg+69Vgtla1HQL0xRT+XD4AJBI5O0N
	5m8RFEnB6dvvBeY/pO9ar1Ut0ykZMsoquA7VuqqKmlJxQ22XEafFAtfRUTZqlf9XXMTuie
	TniyfNRgsgefHSKbXj323iDesFE4Mu2qZhmhHhRkLiMeVlayG/Uu85CSQ10cvkGUsInv9G
	KArryce2XTmnPpQT4JP4p2RDoRpsHxJWODLTpkZKctrV7c4KhB68qdk0aPhx8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740150387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTwNWjVGEeFKvQmeWGEuWKIWLtZMJV1csi/3Mm1y2aY=;
	b=07WDlXTpmUirmc1Ifa7iIlVx1cmOwmM3N8eGvgqAGWE1SW5EOdRMXETI3LHgzgtkwswNb4
	T6kfXsY3rzgukSCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/locking: Use ALT_OUTPUT_SP() for
 percpu_{,try_}cmpxchg{64,128}_op()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214150929.5780-1-ubizjak@gmail.com>
References: <20250214150929.5780-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015038686.10177.10582840569561524852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4087e16b033140cf2ce509ec23503bddec818a16
Gitweb:        https://git.kernel.org/tip/4087e16b033140cf2ce509ec23503bddec818a16
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 14 Feb 2025 16:07:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:56:08 +01:00

x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()

percpu_{,try_}cmpxchg{64,128}() macros use CALL instruction inside
asm statement in one of their alternatives. Use ALT_OUTPUT_SP()
macro to add required dependence on %esp register.

ALT_OUTPUT_SP() implements the above dependence by adding
ASM_CALL_CONSTRAINT to its arguments. This constraint should be used
for any inline asm which has a CALL instruction, otherwise the
compiler may schedule the asm before the frame pointer gets set up
by the containing function, causing objtool to print a "call without
frame pointer save/setup" warning.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250214150929.5780-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd8..0ab991f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -350,9 +350,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -381,10 +381,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -421,9 +421,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -452,10 +452,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\

