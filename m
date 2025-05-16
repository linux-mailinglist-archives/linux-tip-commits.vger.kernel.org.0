Return-Path: <linux-tip-commits+bounces-5616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA1ABA41A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0758A18906C1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E04289361;
	Fri, 16 May 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmOU9GnE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhYTc6DP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A7288C8B;
	Fri, 16 May 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424266; cv=none; b=YhepcuYkcZrciRur6NYO/rFx5Ph34F+UH3V9GPrzz15jD8awoOuI8Q0WxhNoR6HlRx9Rruw5Yq1OiTTSM1xmiAXh5DkU17T6CvEP5tAEah8JQ7mY6n+p0qSelEPjHWQpYUNnETlj3UcGEXf3jeSn8BSN/NW2zIAjCbYY8FCcsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424266; c=relaxed/simple;
	bh=kq/pkSiJ1NKp3k83YE6vHp/Mu4/pkKGUUaaFx4G3Aec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JCz8p/zdbBM7hAYsH8oS5Jt7BgPyAAVdsFJwN/iGYiGSP0/6Z9HBhPJY9qtp17fmtuWqzGBdgleUmNFMmETBHaHyZCx/AuesEte3a81fn9b1PF3y5EtPI841x3N/qxzCOICShLbjocoajkUnUSLbH0MU2xsRjcF1obz2EuYBg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fmOU9GnE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhYTc6DP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FKSQxqWIsJ4/7Fq6bXQ3U2RfYqWYZ7zRPCFi9XQwV8=;
	b=fmOU9GnEC1ko8cycl/00UjzPwBgVZk7YEKlc42inMZRVTHXKyzsT7BvrdT4rNPn6ypWEjf
	xF6nbo1Vuhj8uF1c5Uz+qsuOZsgTkMNC10tHUxt/0b7P+i3z3kDa/cPNWDgxzffERNfaQQ
	D4t1X1WRYb2asi9w51GWcVK+tZe7IMxBbWq85LZlkafQju+hEtPlnlR+Eelt1ixmlGmCJ7
	O4Ia5YRfQ30U3cM/9P1c2jTOjACjh37gVDzt1xFoBy7qX4W7l7pXpTr3M7yp6Duqx2B+dq
	/1XxTrDoglqPraB3TLR/Llz//a8aT5Tmb/hPmFt0hNFWyGklzFoeBPjP3XyV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FKSQxqWIsJ4/7Fq6bXQ3U2RfYqWYZ7zRPCFi9XQwV8=;
	b=QhYTc6DPb0r0jMXY5qSTS4N7+RqlzFzU9MjC4JMR3h5oY+s4HbjUKypT4fvpFCF/zBXuzZ
	K3vzpWcbtvRfYKBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpu: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-19-jirislaby@kernel.org>
References: <20250319092951.37667-19-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426195.406.12008266390501884800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     493e1092676257b81be4c013405f1271497a0ed1
Gitweb:        https://git.kernel.org/tip/493e1092676257b81be4c013405f1271497a0ed1
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:09 +02:00

gpu: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
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
Link: https://lore.kernel.org/all/20250319092951.37667-19-jirislaby@kernel.org


---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++--
 drivers/gpu/drm/msm/msm_mdss.c          | 2 +-
 drivers/gpu/ipu-v3/ipu-common.c         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 19ce4da..38e7043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -725,8 +725,8 @@ static const struct irq_domain_ops amdgpu_hw_irqdomain_ops = {
  */
 int amdgpu_irq_add_domain(struct amdgpu_device *adev)
 {
-	adev->irq.domain = irq_domain_add_linear(NULL, AMDGPU_MAX_IRQ_SRC_ID,
-						 &amdgpu_hw_irqdomain_ops, adev);
+	adev->irq.domain = irq_domain_create_linear(NULL, AMDGPU_MAX_IRQ_SRC_ID,
+						    &amdgpu_hw_irqdomain_ops, adev);
 	if (!adev->irq.domain) {
 		DRM_ERROR("GPU irq add domain failed\n");
 		return -ENODEV;
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index dcb49fd..9d006ee 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -150,7 +150,7 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 
 	dev = msm_mdss->dev;
 
-	domain = irq_domain_add_linear(dev->of_node, 32,
+	domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), 32,
 			&msm_mdss_irqdomain_ops, msm_mdss);
 	if (!domain) {
 		dev_err(dev, "failed to add irq_domain\n");
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index fa77e4e..223e6d5 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1169,8 +1169,8 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 	};
 	int ret, i;
 
-	ipu->domain = irq_domain_add_linear(ipu->dev->of_node, IPU_NUM_IRQS,
-					    &irq_generic_chip_ops, ipu);
+	ipu->domain = irq_domain_create_linear(of_fwnode_handle(ipu->dev->of_node), IPU_NUM_IRQS,
+					       &irq_generic_chip_ops, ipu);
 	if (!ipu->domain) {
 		dev_err(ipu->dev, "failed to add irq domain\n");
 		return -ENODEV;

