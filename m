Return-Path: <linux-tip-commits+bounces-3085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF58F9F6225
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 10:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193F916A203
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7373D165EF8;
	Wed, 18 Dec 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hipDRhzv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtRkFEaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D19156676;
	Wed, 18 Dec 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515378; cv=none; b=Q4Z3ZU8nvxLSGww9qWGV2m1XB/N2U5szoA1HRHN3KQqDoKq2UsrQxjypO7KopCQoTr6r0bzrAw+j7nlz4mecOoyGciMByv4/6lytpPtYtkNgfuODH+SfpkHTdfEFb+gEdbgAqt4pDijufdXunB13XLSC5Bht9qMtrwFmEdTe+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515378; c=relaxed/simple;
	bh=nTabdgcBa8Hlz5G6TlgAkn/4sRozwjv4WKlGaPHK7S4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Elp9inLdJ5xMSgOF54RmetmzEnVpvIwrx2Bg9O+jo57uxOrtJzKvE+Pxt3lFpDMKNGKwGmkE+OVTGd1UfiPprXah19db+ZAadiFF02hBbsIDR41d1kmnh8eLCndpZ5PBXnDAemoS3FbSzNaMa2/bFwJNjcCRcEJhcqNx2G+xHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hipDRhzv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtRkFEaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 09:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734515031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8GJsMnH25dT00b92bY5WcwlUVuKC1hpiLM21Fd0e64=;
	b=hipDRhzv8urMHD69kuBGr47tAmLvBGdnYYdmt/OXh4JwvtgDQKoIpiyL5NGCU0wDMSE3nC
	YLK94ocudtsSWs2LGwxu5rBM4naYdj3qCunyqt2+6CgXRoC9LEoNHBH1JtI+wUGLNa8X0E
	1T7xemmeO0AgWNF+tMzVzpxJBrTWtbs+MDBz6pEIyC2Ta4imM2MjsRoFgrasDo2rIAduf3
	8kI9u9roXasdGbQh3gLFRc18Vc5KNXTzXNGsQOV0xgZX2ASIFl2by3dOmvtCnFXK3iDq+0
	R7MHK/qMF0husHC1nA9ciDeUKSyRPOHdcTmkYl+WgLzpvKpCX7jKuw28nmLXow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734515031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8GJsMnH25dT00b92bY5WcwlUVuKC1hpiLM21Fd0e64=;
	b=OtRkFEaVIGI1W89ycQZPwai+8HPEohkiyUfsAR+WVWIhU/oa4Pa4oEVmvsyqSR37GQZ8cc
	ehbK43Kh7vVD3ABA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/static-call: Fix 32-bit build
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Juergen Gross <jgross@suse.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241218080228.9742-1-jgross@suse.com>
References: <20241218080228.9742-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173451502997.7135.15176892215475394042.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     45dec3ca1fe153cabd79ef8cd05bff64cd2efa52
Gitweb:        https://git.kernel.org/tip/45dec3ca1fe153cabd79ef8cd05bff64cd2efa52
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 18 Dec 2024 09:02:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Dec 2024 10:36:43 +01:00

x86/static-call: Fix 32-bit build

In 32-bit x86 builds CONFIG_STATIC_CALL_INLINE isn't set, leading to
static_call_initialized not being available.

Define it as "0" in that case.

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241218080228.9742-1-jgross@suse.com
---
 include/linux/static_call.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 785980a..78a77a4 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -138,7 +138,6 @@
 #ifdef CONFIG_HAVE_STATIC_CALL
 #include <asm/static_call.h>
 
-extern int static_call_initialized;
 /*
  * Either @site or @tramp can be NULL.
  */
@@ -161,6 +160,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern int static_call_initialized;
+
 extern int __init static_call_init(void);
 
 extern void static_call_force_reinit(void);
@@ -226,6 +227,8 @@ extern long __static_call_return0(void);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+#define static_call_initialized 0
+
 static inline int static_call_init(void) { return 0; }
 
 #define DEFINE_STATIC_CALL(name, _func)					\
@@ -282,6 +285,8 @@ extern long __static_call_return0(void);
 
 #else /* Generic implementation */
 
+#define static_call_initialized 0
+
 static inline int static_call_init(void) { return 0; }
 
 static inline long __static_call_return0(void)

