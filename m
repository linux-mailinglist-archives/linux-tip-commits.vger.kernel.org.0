Return-Path: <linux-tip-commits+bounces-7185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EADEC2C8EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13981883B25
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DCF31619E;
	Mon,  3 Nov 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6o6ViHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwQKR6MM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276C3148B6;
	Mon,  3 Nov 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181256; cv=none; b=b/0pORtV7dyVG09qotuSBADv0lY6JJbOJ2lSzsNMCPrD8CcdeAD13T+Uiaj8f4ep0g7zbWAn0u+tuPnFlqkUDAcx56+EFJlquLHOPljMtK4rBrCzk7dfOdQuHC2AchnBQLdOBlD3pVi8/hMCUJ3Abo8ZHEizfF6mgk1quZ0enyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181256; c=relaxed/simple;
	bh=GdwgNI5BLe/H48VwacSK9bRtLXh3a252ZKD1gmtDJwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hfDiOTKJyihGq2mTHmdDzscFXdy6tQVDiLLd0FaYsgmWkY2hc1susVVciDBh1qWxJyYLQBZlsb/l3hV2iWq7Ql4sb9Gj/M0TpWZy6pknBFtfthKJMUbHEAWUu1sqcSh0Svx2ehDoiuGhQjdnHqwZS80AMH/bsP5nw3QTLkswOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6o6ViHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwQKR6MM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjmSLnsBQRX+IC9H+QQaRpYT8h0dw0KTF5GAGOZuphA=;
	b=f6o6ViHlyNDdJ9Zvvo7boZiIdXSDEI5bswuazSmKefN1GVCf8DopCn1mqEPEPJuWv1qAa9
	YR9edGAZPnbFY8WiIOxnOymCjT3zCfnZBBbizgEJjtVjwUYiGuo3GXbdqyBcyys5q6rdQJ
	DtqjapazLRjmQUPm0zD6wdkL19j9q3/B51xZvXpHOHa8aB2neeile05389rCv8XWX9nuEa
	UouJ4Ojy8/aG1ozFdDTuv2AX/4xNaS7Gz6hLwwjxngwbPqnfLvl7T2WJiexb+tOdAxCV47
	vZMPjaYKy5l06upNv0froAd6+5TQNBQNwbUICz0132X9MxN2RYQW0KM2Xt73ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjmSLnsBQRX+IC9H+QQaRpYT8h0dw0KTF5GAGOZuphA=;
	b=zwQKR6MM8me1PeT85/3OG0QeqKvQJUu1YXDJqGLiV0+oGmxtAFnt1AJQv662EcQTLJ12hl
	c+0F0xpARDNeTaBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Make exit debugging static branch based
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.272660745@linutronix.de>
References: <20251027084307.272660745@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218125226.2601451.5368901710414726276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     10ad7e96d88c286e018c4507add219bbef55bfcf
Gitweb:        https://git.kernel.org/tip/10ad7e96d88c286e018c4507add219bbef5=
5bfcf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:19 +01:00

rseq: Make exit debugging static branch based

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.272660745@linutronix.de
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index f9510ce..5bdcf5b 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -285,7 +285,7 @@ static __always_inline void rseq_exit_to_user_mode(void)
=20
 	rseq_stat_inc(rseq_stats.exit);
=20
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
=20
 	/*

