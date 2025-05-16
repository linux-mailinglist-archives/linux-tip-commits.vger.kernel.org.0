Return-Path: <linux-tip-commits+bounces-5620-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AAABA42E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD37A40CB4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B0289E1F;
	Fri, 16 May 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+SibEI2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="95KlHWB9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587C289805;
	Fri, 16 May 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424269; cv=none; b=KBitGlMhU0qADIu6xFWBYULYJY2g/O9zsgrhaYhYiEOB4ssblJ9et2tkwSmNIpBq61fkBqrk8lbfKCBk7Hwm86cRSEXVrOTN1pOkZUdo0K60+74FxI7a9QqlC1mLfQne035xdOdeTrk+Q3dbjYm1Z4tBADs8C7MSXBAzYSB6bN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424269; c=relaxed/simple;
	bh=zcqmn4Q/ZEail+aOIKf1evCLm4sTz9gw1joUnvWEExo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SQuF9F6n+CpgW72gOTvQSq7vEtKocm3QoYi6pj98yWBLauHJ2+8ig/7cdffyadcsyu3S8pojzFanzBMTyBQIHP0OnhfmkVAGfY0fOwE5s9EU9t2ANByVusoDgcTWfOqzlXvZ3gMY2y2H2FHCM5/kWfhM6Me7ROZHcrxqBvSX+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+SibEI2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=95KlHWB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY+z4DPMKzyBXwC27oLp/Ema9MxEpy4i+zzmIlFo9Wk=;
	b=J+SibEI2IjILIdTHTB7Vk2UphMX0LWRnvBVDD1BbJIXqKJfywB2PXZfgNcxQ+MAAt3e/qH
	aoGyFW5lz5N7KOEEr1ibvhUfONPJFEFtLnvnjbiLPcUpmgkVRQmmRC3h+3szKxZmu5zAKF
	F94ECSEJdK6PhOjMvA4rO8X6rWa8BBq8sQMczv47Er7YixXnBaJgI9Z9g7+oaFXOj3mDK+
	ovkyMJaFLEvvpeUrOO2FyrVoFEIqDyDWHYw38+VjkMpwvEO2G0DD3heiqJRa96vGSYXVNA
	ati/VDO7fbGEim4Jk//s8ky8Xjvw8cWm0IKHZYHuXdImbHDlorQ2Xx3Lcdm/7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HY+z4DPMKzyBXwC27oLp/Ema9MxEpy4i+zzmIlFo9Wk=;
	b=95KlHWB9SxL+2wKFNicuYCn2GqBW1HPMX/keqDqXSYUMrzbzpOL1q/YZ0u1ZAH/eSAFDAc
	3RTNHibkeQMGxVAA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] bus: moxtet: Switch to irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-16-jirislaby@kernel.org>
References: <20250319092951.37667-16-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426424.406.1137215219717843619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     13c984392b28651e9665cc0b05375fa37895bacb
Gitweb:        https://git.kernel.org/tip/13c984392b28651e9665cc0b05375fa37895bacb
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

bus: moxtet: Switch to irq_domain_create_simple()

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-16-jirislaby@kernel.org


---
 drivers/bus/moxtet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1e57ebf..6c3e5c5 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -737,9 +737,9 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 {
 	int i, ret;
 
-	moxtet->irq.domain = irq_domain_add_simple(moxtet->dev->of_node,
-						   MOXTET_NIRQS, 0,
-						   &moxtet_irq_domain, moxtet);
+	moxtet->irq.domain = irq_domain_create_simple(of_fwnode_handle(moxtet->dev->of_node),
+						      MOXTET_NIRQS, 0,
+						      &moxtet_irq_domain, moxtet);
 	if (moxtet->irq.domain == NULL) {
 		dev_err(moxtet->dev, "Could not add IRQ domain\n");
 		return -ENOMEM;

