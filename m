Return-Path: <linux-tip-commits+bounces-8176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INaKAQmKf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:14:49 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFAC6A97
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C9103008D41
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EAF285072;
	Sun,  1 Feb 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LD6A9fft";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YXLEkX0X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95228640B;
	Sun,  1 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966037; cv=none; b=Pz2OTi0U4vaKSzoT/7Am7+Mf3CMi+1M0Js7O/DQ6VUjqsa5RXk/6QqlWv+4vnYCfQb5VEma6Dkwn+7NUexE/ECBK0cYRr38bcE7kICIikbUmJQGFXHwSXzp3AyYgIKrw7QRmrNTwlpUPfNzNA5voc5qcpDqPBO5w1CjnibzSexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966037; c=relaxed/simple;
	bh=keuil+WLiSYfzqd3+SA9VPEstMzDJuY8/gK25tp2/74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fqW7IX6pIhJGCMnQyyVyKfkQaRJG4YYXZBMNOsogxifRVaK5hp7d3HIGAw4YVkNUp7I9WsT7lUyWOLAHUMiouty8I/ChPHOK3dpY1g6NDHr7iWgBjMiDF6Z4hCiHBjF9s+UmSGVN59VzTfrUz2MmJY396fvJ08+feVkZ/Nlfyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LD6A9fft; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YXLEkX0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BOO9L+03Ur2kIqSJkt/r4uDa2BbXs6/sV11NjCgTiM=;
	b=LD6A9ffta2WxlCkWvjnw0ehF1nZeRWe6/4Jc6Ic11ObHd+34LaWCDmmRmbDvtG5MuMOKxk
	vy/x2h5EYgxuEfDOS6DR9N0AlT28nJ91q0zkcSLvuZrzMv9JNKrtNnoRP06KRpw61RxyhC
	7VSY1qLmoT9yMqMZkFdcqSvQiDoHXWtF46klsd/D+Kf5Da+D0deR9k7V7/z/1nidkbHwxz
	bPjUmEFdJuFJNq8e+5hm0Oaka8z7iELUFGkosBMx4KcCmwOD+XY/cxLec2cQrG/U4dz9G8
	E4Ugm8v79lAa82jl4HUdkh090050J3EAgoNMocXH5XZxr6SFV1OoNuPkLOZdyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BOO9L+03Ur2kIqSJkt/r4uDa2BbXs6/sV11NjCgTiM=;
	b=YXLEkX0XAuvEiZ3u3ObrJyJwATk2aJDMdNeRE0kgWZfDMu/4A6JsjgJPIATDCzxnPO4/dp
	hEmzPBwI3OHR+kAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iommu/amd: Use core's primary handler and set
 IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-4-bigeasy@linutronix.de>
References: <20260128095540.863589-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996603153.2495410.8007230412946283843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8176-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 97AFAC6A97
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     5bfcdccb4d18d3909b7f87942be67fd6bdc00c1d
Gitweb:        https://git.kernel.org/tip/5bfcdccb4d18d3909b7f87942be67fd6bdc=
00c1d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:23 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:13 +01:00

iommu/amd: Use core's primary handler and set IRQF_ONESHOT

request_threaded_irq() is invoked with a primary and a secondary handler
and no flags are passed. The primary handler is the same as
irq_default_primary_handler() so there is no need to have an identical
copy.

The lack of the IRQF_ONESHOT can be dangerous because the interrupt
source is not masked while the threaded handler is active. This means,
especially on LEVEL typed interrupt lines, the interrupt can fire again
before the threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: 72fe00f01f9a3 ("x86/amd-iommu: Use threaded interupt handler")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-4-bigeasy@linutronix.de
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 12 ++++--------
 drivers/iommu/amd/iommu.c     |  5 -----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b742ef1..df1c238 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -15,7 +15,6 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
-irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b..62a7a71 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2356,12 +2356,8 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	if (r)
 		return r;
=20
-	r =3D request_threaded_irq(iommu->dev->irq,
-				 amd_iommu_int_handler,
-				 amd_iommu_int_thread,
-				 0, "AMD-Vi",
-				 iommu);
-
+	r =3D request_threaded_irq(iommu->dev->irq, NULL, amd_iommu_int_thread,
+				 IRQF_ONESHOT, "AMD-Vi", iommu);
 	if (r) {
 		pci_disable_msi(iommu->dev);
 		return r;
@@ -2535,8 +2531,8 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iom=
mu, const char *devname,
 		return irq;
 	}
=20
-	ret =3D request_threaded_irq(irq, amd_iommu_int_handler,
-				   thread_fn, 0, devname, iommu);
+	ret =3D request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
+				   iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5d45795..bd57785 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1151,11 +1151,6 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
=20
-irqreturn_t amd_iommu_int_handler(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 /****************************************************************************
  *
  * IOMMU command queuing functions

