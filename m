Return-Path: <linux-tip-commits+bounces-2938-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4969E0030
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F6163D7D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477A20ADFE;
	Mon,  2 Dec 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bomp437w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f73jJtHM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730691FE47E;
	Mon,  2 Dec 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138125; cv=none; b=lJaLtrkmAUxuPvUubuhduziETdvPahG11TEnoEe+4x4SU6sIibkTVYwC1hxXSneeB9Ptx7auON2UJVlvRm3H1FXE9aUFXRFJD0nfYLr6N+IjGr1Tzfb4RZqUGCThimemEGE10HNP2s0z1+DCcV8U8ThbKGmMLHBg3nx+xwht8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138125; c=relaxed/simple;
	bh=uiXJKsc+8GlxfzKFQY+ksMPTqB1Y+aAQ8NMPnRMk9ew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mOaFBRqcDyaobWMPU/6X3IJs8QT5x0dc2BHguq/Z7d3BH+l3OcIjRmC659kFPdx7o9v+gMeByvQiizYtC1SMeICMFgQAvxKRo4KLaViBqYtJ5ZIJK/IbgHHF906OuSsQTcGPIvIzGhuvO51z+Nn6Lb9LvhCDSECH1hjupVSP8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bomp437w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f73jJtHM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JE0M1113ulAjR0N6Z9/lLgvvkL8xra19PieaH6j+sg=;
	b=bomp437whVLv9cEwG2WMIon75WQ14BAuVTpS1oYSeWOtbNEa0BfMBYyc1xudeQg5RedlgL
	D9imrXvmKQEal6bn1900A/qAtOLvBvFcbLTXMUVtbeSF0A2MPwVHbftBKsRUpDUAWU94AX
	nLp1WBuT0Q1MmTy3McF6SliWigZdA7fCc1FlXwuA1y9rwMVC+tWfgOFoyfbH5xDsf9zd+C
	TzZn1O60MVAolbk2RcwEIHWu4BLCHA/IK+wzgWIKDyk4XRbOhiXP9NyRSi6jgfZKh3p2gH
	ZOOHvjIi8VEvlcNe5noh31zm7fv/ThebFQwu6lcEnnnCTBPxn9BbKYMzuFTTsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JE0M1113ulAjR0N6Z9/lLgvvkL8xra19PieaH6j+sg=;
	b=f73jJtHMD4Ap0b9TFaiSUdq4vEV0tqFtFbWaV3LH/08ZRXgz/fe+p1Q+56fj1A0WayPdtf
	oDP5gUpeXK9s7lAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] loongarch: Use ASM_REACHABLE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.133437051@infradead.org>
References: <20241128094312.133437051@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812117.412.9274396373032434527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     624bde3465f660e54a7cd4c1efc3e536349fead5
Gitweb:        https://git.kernel.org/tip/624bde3465f660e54a7cd4c1efc3e536349fead5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:44 +01:00

loongarch: Use ASM_REACHABLE

annotate_reachable() is unreliable since the compiler is free to place
random code inbetween two consecutive asm() statements.

This removes the last and only annotate_reachable() user.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.133437051@infradead.org
---
 arch/loongarch/include/asm/bug.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 0838887..561ac1b 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <asm/break.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -33,25 +34,25 @@
 
 #define ASM_BUG_FLAGS(flags)					\
 	__BUG_ENTRY(flags)					\
-	break		BRK_BUG
+	break		BRK_BUG;
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
-#define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+#define __BUG_FLAGS(flags, extra)					\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
+			     extra);
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
-	annotate_reachable();					\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(0);						\
+	__BUG_FLAGS(0, "");					\
 	unreachable();						\
 } while (0)
 

