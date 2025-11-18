Return-Path: <linux-tip-commits+bounces-7391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D84C6A285
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E8D542BB7B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25525361DDF;
	Tue, 18 Nov 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OwvZtb2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WoT0jOYY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88995361DCD;
	Tue, 18 Nov 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477860; cv=none; b=PEbuDbw1h4ibbaPYZdi0SW898iOTtlfNJlA09yNC9d+1WfU2KWEBI4zPOng78k9Tr1ceV/6yHrtV5Isg7dMK32r8WuaZv6e9XHUDZ6zeFOmdKIdtTDArDDYdJmYmmot+CPV2p+LZiT1idJ8eObwXOLx8Z5egDOKLYi68lzriwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477860; c=relaxed/simple;
	bh=jqEDppRx3i/PCvvNxnD0cc9vRN5yhythPdS9IBFiqnc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tiA6SryhUxTWgMKZJRdoHDqSQlvf9A0i0LeMWJfbNJOW11FQ6xBhVYKJ7/sk10nxeHM1r7sn9F6UeTMBeR193sAMK4PtcjWdlsaSrt+AGy/mc0Uj4sY2ZXJH8W1Ef2H/uwVep59XxQaX1Lfjg5Auv7t3KcWGiKRWUS1LCbcHFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1OwvZtb2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WoT0jOYY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 14:57:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763477857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe4hqoK40X5rrCSgqng4dtlUgywPiZAkPuz8c6S+uko=;
	b=1OwvZtb2HGab84RxMlGZ/4ey/gJ4FKHMegm14eLfeVmp6Ihnfiiir+UfkCsr1hk4hqGDig
	7hAjqBQTQGoVy0GtzjN9d7BqM0uLH9JY3SZngwptdvO8uet4rcL3RRPjoWbdLeOdkOuFkq
	uieAJUDz5Uzb6LG13zRHoc+PkMfN+tnAZWYYMquPHuxdI5ccG5i+hB9XT2Uo+HuFe+9njz
	VXzfxKDQviw7+6uI+yPqBVIQwpDYWVMW3a7ngdE0GRqoqFGsWOkanzoTlKshhtr50ogh5Q
	0GC7f3YDANnkihOlmI8h4Dd8VcWKFOJFZZcAHsEiQPFnByzmdqoFKzab3Dd6EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763477857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xe4hqoK40X5rrCSgqng4dtlUgywPiZAkPuz8c6S+uko=;
	b=WoT0jOYYWlE3LEy/GQtfkFJRnZE1gz4z7Alblj/yTunb5ZMqZOjxLYKh7BW1S95szNR709
	TaOn5BxfpNoD/CAA==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Delete duplicate if statement in
 rseq_virt_userspace_exit()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aRxP3YcwscrP1BU_@stanley.mountain>
References: <aRxP3YcwscrP1BU_@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347785546.498.16294534513000187167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     80adaccf0e1c8c8fff44be2d959f6dba80af0491
Gitweb:        https://git.kernel.org/tip/80adaccf0e1c8c8fff44be2d959f6dba80a=
f0491
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Tue, 18 Nov 2025 13:52:13 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 15:56:55 +01:00

rseq: Delete duplicate if statement in rseq_virt_userspace_exit()

This if statement is indented weirdly.  It's a duplicate and doesn't
affect runtime (beyond wasting a little time).  Delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/aRxP3YcwscrP1BU_@stanley.mountain
---
 include/linux/rseq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index b5e4803..bf8a6bf 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -126,7 +126,6 @@ static inline void rseq_force_update(void)
  */
 static inline void rseq_virt_userspace_exit(void)
 {
-	if (current->rseq.event.sched_switch)
 	/*
 	 * The generic optimization for deferring RSEQ updates until the next
 	 * exit relies on having a dedicated TIF_RSEQ.

