Return-Path: <linux-tip-commits+bounces-3688-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A8BA46621
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753663AE803
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BA5186E2D;
	Wed, 26 Feb 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbcHQmrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcDfBHiY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E72904;
	Wed, 26 Feb 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585901; cv=none; b=tYIvLKK7Q+z/YN2h4/zEGxcFwjyBnjcpF1x/gXL6fMWiUQgxL2PEb/vH0b2X6Pj+ZaLCtJrA9STbEL6HEzBlWzeL0WbHFPIoYtM7Vcg8RAWr2ZvzKQwqLGWYjaxQK4ScJ7bln5iTWZ7EQhKbYVojtLsWT7sv+JZA+vJw0/0iJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585901; c=relaxed/simple;
	bh=U8ufv9DviLt/8yY4Rpc+Z0Yp3/2EuP/o85FpXz7GPGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GXcPRFFVwN07JbH23mQOUkjr7EJuTfdtx9/6IPj1yRPabjQHwsrOWgTxRAgLdD1/3EgAQyf6cHVOQyJ22vFfszhDwK90zO5wNjCYhHEo9OfSnZiZ8sasT9iR86VMWASKYsGgF8MGqQXF8xbodbpMwAxWqTp/J/lJmo9Kwisymi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbcHQmrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcDfBHiY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 16:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740585898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj3JsdFnVpjYj9X33GJqupyrDWu86/pBcCKTYcMi0ac=;
	b=dbcHQmrUQpEP5nF7GBaes1tlrh03KdxTVXJ89Uyy/LXbPY3NNfBo1y0oe6DlUNdIUKxh3N
	CqJ1/sNOZ+0n8b2i5brDoDyrdkYbWqd0sWezUsoFfGIMLDYdIX1DzsN4DJ8zGwlsPn6iup
	r1AeujgjvK8kzo3VjR0rqkiZE/E0iFjApiXxor48CdPDx5l5LwiOEy2qCCsljUumbvy3S3
	d9FKbMhgQp4vykDH8RXH7QXKf2eftM12X2u0GIFKQK82BhkG2THQqyne7C93rcslj1NsiO
	KnAxdxH+tZZkebdiDgpRWnzWX14Pr4Vyzcpn4Tk8r25ja3tPlqU9WnA7beFy0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740585898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj3JsdFnVpjYj9X33GJqupyrDWu86/pBcCKTYcMi0ac=;
	b=tcDfBHiYfvVLH0XWl2b79BrdZjRyW2M58jty7b67sMdhhQezNrwycHLVk/KZ+0U5V2Petd
	oaWJFtqhRQRT4BBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] posix-clock: Remove duplicate compat ioctl() handler
Cc: linux@weissschuh.net, Thomas Gleixner <tglx@linutronix.de>,
 Cyrill Gorcunov <gorcunov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250225-posix-clock-compat-cleanup-v2-1-30de86457a2b@weissschuh.net>
References:
 <20250225-posix-clock-compat-cleanup-v2-1-30de86457a2b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174058589753.10177.9335743981668865509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7a6b158e00c862ccfa7fe447682bd0bf5c229c73
Gitweb:        https://git.kernel.org/tip/7a6b158e00c862ccfa7fe447682bd0bf5c2=
29c73
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 25 Feb 2025 18:00:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 16:53:58 +01:00

posix-clock: Remove duplicate compat ioctl() handler

The normal and compat ioctl handlers are identical,
which is fine as compat ioctls are detected and handled dynamically
inside the underlying clock implementation.
The duplicate definition however is unnecessary.

Just reuse the regular ioctl handler also for compat ioctls.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Link: https://lore.kernel.org/all/20250225-posix-clock-compat-cleanup-v2-1-30=
de86457a2b@weissschuh.net

---
 kernel/time/posix-clock.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2..7f4e4fb 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -90,26 +90,6 @@ static long posix_clock_ioctl(struct file *fp,
 	return err;
 }
=20
-#ifdef CONFIG_COMPAT
-static long posix_clock_compat_ioctl(struct file *fp,
-				     unsigned int cmd, unsigned long arg)
-{
-	struct posix_clock_context *pccontext =3D fp->private_data;
-	struct posix_clock *clk =3D get_posix_clock(fp);
-	int err =3D -ENOTTY;
-
-	if (!clk)
-		return -ENODEV;
-
-	if (clk->ops.ioctl)
-		err =3D clk->ops.ioctl(pccontext, cmd, arg);
-
-	put_posix_clock(clk);
-
-	return err;
-}
-#endif
-
 static int posix_clock_open(struct inode *inode, struct file *fp)
 {
 	int err;
@@ -171,11 +151,9 @@ static const struct file_operations posix_clock_file_ope=
rations =3D {
 	.read		=3D posix_clock_read,
 	.poll		=3D posix_clock_poll,
 	.unlocked_ioctl	=3D posix_clock_ioctl,
+	.compat_ioctl	=3D posix_clock_ioctl,
 	.open		=3D posix_clock_open,
 	.release	=3D posix_clock_release,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	=3D posix_clock_compat_ioctl,
-#endif
 };
=20
 int posix_clock_register(struct posix_clock *clk, struct device *dev)

