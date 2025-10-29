Return-Path: <linux-tip-commits+bounces-7075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D85C19BEA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E011C618F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84A33CE8C;
	Wed, 29 Oct 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wj0oQKo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FFoV3wHG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928903376BA;
	Wed, 29 Oct 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733439; cv=none; b=KzLz3yNHtOQvE6z98cxWfbEaOONtiIZnJ/h/JD2gIGRqAzR7pqDxY2cHi46Ahv/+q+IxPVHejsI6ECvc12Eoh+W/G7GlI68EwzidCcOQCsRe2gsY7zsNbK4iGqoaF6XzbjgyaY22N1rLwSz1vYQTKJw3oA6ioSv7174KKvYbX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733439; c=relaxed/simple;
	bh=GSQib9Q4Nf0aFe+VPJoD/7P68YVjVS6OcWpRP63h0B8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c2LhqByCaegXSDSOA3b1otHazdRu7gKd4GAUCAyINEG8YSCKiawdKzTd2oI+vXJ7+qfJP5aP25wXuaPfnj4EAjvZxL1/j+ZfTblQac1BKUvdRYR6yF3fmaFAYhMZ+kOK6AkmsLocGAFFQSCH/4FXGlgGdBit9jJ6wk4uDjow4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wj0oQKo/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FFoV3wHG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/4h/KjOrqH4KOyZroS28wSIzYm6jgbAe1dEBgJaCho=;
	b=wj0oQKo/inaO3MROsWRmlEDeEYjM17uMnz7QDcbZ2GGCvhfxp9t63EYMh4jNqECDkyy0NT
	9mtbsLTP2aMXp1ckFp/LWlgLjIf31RxdKPT2CaEMA+6y/uiTW+n+VfsBfTClv0elEOj+f+
	sJHZqrpjZhPJSF8zdsqpfpQQEZxhacOBLSohfir5LO5817blE7cnUr8ONRjmAchHv1sL2M
	PwanVGa7jEWZeYJ5o3i+Ti8q9WNAKcaeelbBHc4ex5kbTDqwl8hWzcceM9R20Ad3axejTy
	Wd7G+IfqVTGbtGtYxCeInvi3yxKsxS5ixoLyMAz1sdtMPmzSZZXZ4oT/Dd6NZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733436;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/4h/KjOrqH4KOyZroS28wSIzYm6jgbAe1dEBgJaCho=;
	b=FFoV3wHGleafybaEq0S7Kvj30QHLTGuOS/zpVlgXdB7wzDSjBWkbgOHlP1+umZesZSoh49
	rnUeGawJG0/GVYBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Avoid CPU/MM CID updates when no event pending
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.462964916@linutronix.de>
References: <20251027084306.462964916@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173343466.2601451.4500707359293486321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     49c347874852230f8a7a419ef1faa871f5b2206e
Gitweb:        https://git.kernel.org/tip/49c347874852230f8a7a419ef1faa871f5b=
2206e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:13 +01:00

rseq: Avoid CPU/MM CID updates when no event pending

There is no need to update these values unconditionally if there is no
event pending.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.462964916@linutronix.de
---
 kernel/rseq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 01e7113..81dddaf 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -464,11 +464,12 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 		t->rseq_event_pending =3D false;
 	}
=20
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
-		ret =3D rseq_ip_fixup(regs, event);
-		if (unlikely(ret < 0))
-			goto error;
-	}
+	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
+		return;
+
+	ret =3D rseq_ip_fixup(regs, event);
+	if (unlikely(ret < 0))
+		goto error;
=20
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;

