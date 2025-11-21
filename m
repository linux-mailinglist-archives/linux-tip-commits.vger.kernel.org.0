Return-Path: <linux-tip-commits+bounces-7444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12303C78528
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC94EC940
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAA3446DB;
	Fri, 21 Nov 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbGlZ2bI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRVMhfhR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD5217736;
	Fri, 21 Nov 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719076; cv=none; b=gbWAvuuHwv7dwMFaDu6KDRiNczMTwxt+BccGK8v66UZFuWZ59HaktZGpfDOwwwG88L5iWkep0jum/ft61e/3KByLbWFjv8MuNtA4nYPhbomQVZBgREWDqIMcibSY/1YcD3SRj7Jucc3feY6WESn+UA/wf+hVz2Q+PFLq9syAR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719076; c=relaxed/simple;
	bh=C68Zkx20eiEh0v1A7dM67dcAC66jIusNlYBbHBvaHC8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qGCnFn1nMlfYxkliv/p3nHpjoXbzlujVnmkLOq7OpNSn1h4z/k4U7oDlqcNItU1pupf4/LYjrhqAMgLH/4OmQOCfR+4WT/eFMgxxCd/vcMZsSJWPPfF9eLWimpxGIGkUcIfla5uU/hBq8xk2BuXmCdjoA6pUWjxOui5o0NSUGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbGlZ2bI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRVMhfhR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO2il5YkVchlDSRMS+gYDvra8h4EqcrPmPHZiQSf3Us=;
	b=dbGlZ2bIAA2Hk0pf4bZZUnJZlmP3pYxHRuL6c5VTk6c8xj3Vvy3hIlzWvFmriXlJsirhXF
	OsHbmPJELp3qvDoFzsbieUtI2+nwgVwH+2u7Yw83acEK9k+Tnzi9jb+iTjHXj/ngDqSUHT
	AGg3XI7Ny+F1FQgWFNBXd9vtmhaBPEd2NG4If8UuYwE8XMwv/GdsV/CnQMlHPLskEU24tC
	S/H3F72BUQozlxGP13tfMDHdWAQ6cuo7WVy/piIlwdzcFVW4YbLhagC0G2owUnGyJi5dDP
	b8LFDAC73YVWQIhSLfwHUjFdostkxqL3hcqge2PvRhd8O9wDAc6pjWaPHkZxGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO2il5YkVchlDSRMS+gYDvra8h4EqcrPmPHZiQSf3Us=;
	b=dRVMhfhRo8j8UWWiS8q/OaAMyRLXq/g5jl8ox5i7CyYpCOjL3paGHYQKBqrjt54RnR9TlA
	hMayOpnsQ2XdEvDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tty: synclink_gt: Fix namespace collision and
 startup() section placement with -ffunction-sections
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f0ee750f35c878172cc09916a0724b74e62eadc2.1763669451.git.jpoimboe@kernel.org>
References:
 <f0ee750f35c878172cc09916a0724b74e62eadc2.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371906124.498.17999411437565788579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     31863337138a0482d614f1090727dac87c936959
Gitweb:        https://git.kernel.org/tip/31863337138a0482d614f1090727dac87c9=
36959
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:19 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:10 +01:00

tty: synclink_gt: Fix namespace collision and startup() section placement wit=
h -ffunction-sections

When compiled with -ffunction-sections (e.g., for LTO, livepatch, dead
code elimination, AutoFDO, or Propeller), the startup() function gets
compiled into the .text.startup section (or in some cases
.text.startup.constprop.0 or .text.startup.isra.0).

However, the .text.startup and .text.startup.* sections are also used by
the compiler for __attribute__((constructor)) code.

This naming conflict causes the vmlinux linker script to wrongly place
startup() function code in .init.text, which gets freed during boot.

Some builds have a mix of objects, both with and without
-ffunctions-sections, so it's not possible for the linker script to
disambiguate with #ifdef CONFIG_FUNCTION_SECTIONS or similar.  This
means that "startup" unfortunately needs to be prohibited as a function
name.

Rename startup() to startup_hw().  For consistency, also rename its
shutdown() counterpart to shutdown_hw().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/f0ee750f35c878172cc09916a0724b74e62eadc2.17636=
69451.git.jpoimboe@kernel.org
---
 drivers/tty/synclink_gt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 3865b10..9d591fb 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -407,9 +407,9 @@ static void  wr_reg32(struct slgt_info *info, unsigned in=
t addr, __u32 value);
=20
 static void  msc_set_vcr(struct slgt_info *info);
=20
-static int  startup(struct slgt_info *info);
+static int  startup_hw(struct slgt_info *info);
 static int  block_til_ready(struct tty_struct *tty, struct file * filp,struc=
t slgt_info *info);
-static void shutdown(struct slgt_info *info);
+static void shutdown_hw(struct slgt_info *info);
 static void program_hw(struct slgt_info *info);
 static void change_params(struct slgt_info *info);
=20
@@ -622,7 +622,7 @@ static int open(struct tty_struct *tty, struct file *filp)
=20
 	if (info->port.count =3D=3D 1) {
 		/* 1st open on this device, init hardware */
-		retval =3D startup(info);
+		retval =3D startup_hw(info);
 		if (retval < 0) {
 			mutex_unlock(&info->port.mutex);
 			goto cleanup;
@@ -666,7 +666,7 @@ static void close(struct tty_struct *tty, struct file *fi=
lp)
 	flush_buffer(tty);
 	tty_ldisc_flush(tty);
=20
-	shutdown(info);
+	shutdown_hw(info);
 	mutex_unlock(&info->port.mutex);
=20
 	tty_port_close_end(&info->port, tty);
@@ -687,7 +687,7 @@ static void hangup(struct tty_struct *tty)
 	flush_buffer(tty);
=20
 	mutex_lock(&info->port.mutex);
-	shutdown(info);
+	shutdown_hw(info);
=20
 	spin_lock_irqsave(&info->port.lock, flags);
 	info->port.count =3D 0;
@@ -1445,7 +1445,7 @@ static int hdlcdev_open(struct net_device *dev)
 	spin_unlock_irqrestore(&info->netlock, flags);
=20
 	/* claim resources and init adapter */
-	if ((rc =3D startup(info)) !=3D 0) {
+	if ((rc =3D startup_hw(info)) !=3D 0) {
 		spin_lock_irqsave(&info->netlock, flags);
 		info->netcount=3D0;
 		spin_unlock_irqrestore(&info->netlock, flags);
@@ -1455,7 +1455,7 @@ static int hdlcdev_open(struct net_device *dev)
 	/* generic HDLC layer open processing */
 	rc =3D hdlc_open(dev);
 	if (rc) {
-		shutdown(info);
+		shutdown_hw(info);
 		spin_lock_irqsave(&info->netlock, flags);
 		info->netcount =3D 0;
 		spin_unlock_irqrestore(&info->netlock, flags);
@@ -1499,7 +1499,7 @@ static int hdlcdev_close(struct net_device *dev)
 	netif_stop_queue(dev);
=20
 	/* shutdown adapter and release resources */
-	shutdown(info);
+	shutdown_hw(info);
=20
 	hdlc_close(dev);
=20
@@ -2328,7 +2328,7 @@ static irqreturn_t slgt_interrupt(int dummy, void *dev_=
id)
 	return IRQ_HANDLED;
 }
=20
-static int startup(struct slgt_info *info)
+static int startup_hw(struct slgt_info *info)
 {
 	DBGINFO(("%s startup\n", info->device_name));
=20
@@ -2361,7 +2361,7 @@ static int startup(struct slgt_info *info)
 /*
  *  called by close() and hangup() to shutdown hardware
  */
-static void shutdown(struct slgt_info *info)
+static void shutdown_hw(struct slgt_info *info)
 {
 	unsigned long flags;
=20

