Return-Path: <linux-tip-commits+bounces-7504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0962BC7F863
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6219B4E437A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BC2FD7BA;
	Mon, 24 Nov 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNjdOFze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNHpaCSO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E632FE07B;
	Mon, 24 Nov 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975524; cv=none; b=OkyMh/nfbHo+gzI1NBg+LF6k0dl1UmuZCmORMTXlJbd7fHD2k1ARdhOWt4qSiWZfCcvOgCMLZxsYQVopK9SBT6JBRkkpF2VfUiZHEBm43d0BxjrFlh1Kt/zTL9Cb+2CqDeJ2a6n1WxlIcog8lddxGTYV5P3UP66vbNf/1DEfk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975524; c=relaxed/simple;
	bh=OTP3CWV8qWwODAnDRMCxNLLt+L0xuGF9+nSgkWAJ2/g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O3mU7u1xD2voGERBeI5MvTVuMleqLDDTmM9A+GrKV6xv3TuOdiyXXQmIhZJvw1MY8EqDbKUnnQJDP/VT8QoYIuq8iN9Vq1b5P3DtCbKE+80cJ/fF6s77HRApTNOZPIfkaXJfePGy8lTo0LejUsYPv83ekGvBJ0Iw/J7hXuItpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNjdOFze; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNHpaCSO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMiwtzdU6APaQ0TXrkvm93x9VHheSeGEjzr6U+EmHtI=;
	b=PNjdOFzeM524tkMC+A23YOSPS3wxWQamTEdocQ4cExGz/PIgcxlaUuqLbptiPBMKtzGXhg
	cRBbgg0ZRm77f32+kiG9M8lbIkAl4jwpyIq0dOz2nCMyYagFzP0WLSIdiTCA0lR/VW/Fo+
	1pcRtPGDD2Milnz9fLMakbIksMe41qbhGIfF6JoC0vpMeRiHy/xL1maM8eibrSmlzE3/zT
	bSEePxxnrYFUHGGcKo9C0wuTghSGyMymaCmhhXLlp8wS2szvuCL1Iz8G/7Iv8kYQRD0q3H
	R5NwHIhZvdtpaWSWIyYsNtYk0P4hXRb6C6oKxiVEArHWE1FPI5uKR3C7hLiivg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMiwtzdU6APaQ0TXrkvm93x9VHheSeGEjzr6U+EmHtI=;
	b=TNHpaCSOBeTTZtcA65BdC9VQWtbeWawQaHajErpLkD7laCO74WMokzg5mPkCQ04jY5s5Qe
	WVHOkjmu1J2qvdBg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] tool build: Remove annoying newline in build output
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-5-alexandre.chartre@oracle.com>
References: <20251121095340.464045-5-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397552035.498.10265417299927273383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f348a44c103aac04fc9420d993afa4ab5cf5e3e2
Gitweb:        https://git.kernel.org/tip/f348a44c103aac04fc9420d993afa4ab5cf=
5e3e2
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:07 +01:00

tool build: Remove annoying newline in build output

Remove the newline which is printed during feature discovery
when nothing else is printed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-5-alexandre.chartre@orac=
le.com
---
 tools/build/Makefile.feature | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 32bbe29..300a329 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -315,5 +315,7 @@ endef
=20
 ifeq ($(FEATURE_DISPLAY_DEFERRED),)
   $(call feature_display_entries)
-  $(info )
+  ifeq ($(feature_display),1)
+    $(info )
+  endif
 endif

