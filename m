Return-Path: <linux-tip-commits+bounces-7245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640EC2FD4F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DDA3A8DF1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA331E0FF;
	Tue,  4 Nov 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2QtpX1XF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwtI/hyT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2A31D396;
	Tue,  4 Nov 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244258; cv=none; b=FafTE3o9ScrKrlqrr3YGHvOoN1RI3Q0/b1qaXBsUeVik7PdbGquXEywwGGr8gjOsQTBlLzaGsPAelo3B4r+fesiafavTmVM/PnzY14pNOA3h2YKK4oQCV7F9xOYDr4HJYrIXRv6kNedPoCTIY9bcwX5D4WTt8KiiZClI5er5QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244258; c=relaxed/simple;
	bh=2wifGR2S1YeYJlqfJc4OOPbSSM/F6Tg+/ogP7o8g024=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P/wqZTNTg1aGQkJTLzbIbbtqTMW0QDyzzBasZlN1teOxZkuiM1uyMkfGvOWfLXJnV52MlxixHDGaC6VVErsy/+0pUi0lIcU4sH8oHdmX07RdN1HE08qQ7fqn/D62aSWySkqcfTNIy+Muscjk01N2/mVIlBcXbUirLVFMQ0xj8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2QtpX1XF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwtI/hyT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1msc6RGrlUYRuzQg+IovsuYAqWsDYQBv0dwybLk+5kg=;
	b=2QtpX1XFhR9wXKUeKfL3zICNPa6UPS9KCTb5P8pJUxlIuv4J08cfJLNvdQgdl9zwx5U5Rq
	Jl0OYDvIL81sh8JZUML8Iuy245+o2kAuPmKvtytXGtwNZPzmQfCEndCviwXJ9dSvq1i64P
	oGTltAri1LV6pkhU+MrggLZ8OjpUrc/IG2Nz6hJU+qWS8x0MlOWq0ZPeG/ULvHx6Wp/RO/
	GthT8Jh57g3YpLyvM85je1u4nWnlKNO0SzcQ+hiXaVzpZCCm/CZZ9yzV+bws8wCzWavVj6
	r4D2W4pC3eMKQjkqRflV0E+/BkEcxr+gUUsL+hvm77NJ6+OVYIBZ32MzKKXlRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1msc6RGrlUYRuzQg+IovsuYAqWsDYQBv0dwybLk+5kg=;
	b=bwtI/hyT8MkqbaBSe0zK8JczmN9RZiVd/EOAUnI2Y8eJmARnhZi5K4ah7XD8BoxkPG14NW
	97JsYwJkuSkgvUDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Avoid CPU/MM CID updates when no event pending
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224425380.2601451.8614581745521070941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     566d8015f7eef11d82cd63dc4e1f620fcfc2a394
Gitweb:        https://git.kernel.org/tip/566d8015f7eef11d82cd63dc4e1f620fcfc=
2a394
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:43 +01:00

rseq: Avoid CPU/MM CID updates when no event pending

There is no need to update these values unconditionally if there is no
event pending.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

