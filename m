Return-Path: <linux-tip-commits+bounces-7354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A6C5E748
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 18:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38C6C367CAA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A333BBA0;
	Fri, 14 Nov 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iD3EYGVK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+rp+nFt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F03396F1;
	Fri, 14 Nov 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134398; cv=none; b=eUA8fYSMKtgwI/pPIy/1jFCJgCwuggyKPvOcnZNb0fmv1+vOCuUUM4K1STGL/CTWh2JBMeIjf41IgOK2HJ1me+4dHk99OF2s9graUgpGOgatiEGOjMyRHRqCkhI/aZXcTbMk67SVNupUhaK2rMjFwyKNCSCFY2MXPARtnCjcAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134398; c=relaxed/simple;
	bh=cBlwvjLu0jH1FZ3KrUFDIsArAp2m3c9F0kK/YTDNybQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G/eHtLB5Bo7dvYBMnqf+jkrl+VxZ3ngryC8D/5haCUKHyuMUlQFZG/RYeYgg5dsQUq2bfyMxVWywiNpySMwgef50bwb6sjaPqO+2xdCcEq8JFJxOV7aX+W9L2k2MUKHPMcHNF2QCZ2Ct1q6987Bf+GgScbHP5wCQg8PU2TC6TGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iD3EYGVK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+rp+nFt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 15:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763134395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dndM/hTZ3HwEjjbXFedQTNRvpH5gMxhGB/SR0EIPu5M=;
	b=iD3EYGVKwqdEfXuXGEyZd6hZ2HZ68HeagcHjcbJEtsoWNf6qAdKvj/6cMgWSSJ1/4GcZ6v
	bB9kvPYxQpNHNhphNS4xoGO4UFdWvCWsrPqE9DjR4uxsRbTRh7bySk/BswWfC9JoBXYc+5
	63jA3fjAk4Ri8Hi5b4Z1VyfnSHiJsFUzv3YcQmvAH9ZL0O24pex2qbucFT2W/sfNyPIhfr
	wuLo5+yRekU4QT/rhMk7Vx3HnN8WIgfZNNgltlMbtenqXOd+zaEipbctbV3kxguYDaax6D
	NkSr1NjAWVhjerjWL7l7W4lKHF3oMyodVjjE9Rf+Y8krwudlE3ajhCjRQpaP7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763134395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dndM/hTZ3HwEjjbXFedQTNRvpH5gMxhGB/SR0EIPu5M=;
	b=M+rp+nFtbHgnm+NybzLclg+17rLK8xCrmQsegiNR5zK822KKHJXJmQkBmCOtzik3342vaN
	S/4UiKQUwFi3RRBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Store time as ktime_t in restart block
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Jan Kara <jack@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20251110-restart-block-expiration-v1-2-5d39cc93df4f@linutronix.de>
References:
 <20251110-restart-block-expiration-v1-2-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176313439408.498.1645769750771932244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     c42ba5a87bdccbca11403b7ca8bad1a57b833732
Gitweb:        https://git.kernel.org/tip/c42ba5a87bdccbca11403b7ca8bad1a57b8=
33732
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 10 Nov 2025 10:38:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 14 Nov 2025 16:29:53 +01:00

futex: Store time as ktime_t in restart block

The futex core uses ktime_t to represent times, use that also for the
restart block.

This allows the simplification of the accessors.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20251110-restart-block-expiration-v1-2-5d39cc9=
3df4f@linutronix.de
---
 include/linux/restart_block.h |  2 +-
 kernel/futex/waitwake.c       |  9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 7e50bbc..4f9316e 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -32,7 +32,7 @@ struct restart_block {
 			u32 val;
 			u32 flags;
 			u32 bitset;
-			u64 time;
+			ktime_t time;
 			u32 __user *uaddr2;
 		} futex;
 		/* For nanosleep */
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index e2bbe55..1c2dd03 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -738,12 +738,11 @@ int futex_wait(u32 __user *uaddr, unsigned int flags, u=
32 val, ktime_t *abs_time
 static long futex_wait_restart(struct restart_block *restart)
 {
 	u32 __user *uaddr =3D restart->futex.uaddr;
-	ktime_t t, *tp =3D NULL;
+	ktime_t *tp =3D NULL;
+
+	if (restart->futex.flags & FLAGS_HAS_TIMEOUT)
+		tp =3D &restart->futex.time;
=20
-	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
-		t =3D restart->futex.time;
-		tp =3D &t;
-	}
 	restart->fn =3D do_no_restart_syscall;
=20
 	return (long)futex_wait(uaddr, restart->futex.flags,

