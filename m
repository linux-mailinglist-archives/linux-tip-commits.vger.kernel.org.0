Return-Path: <linux-tip-commits+bounces-5300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5393AAC5F7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E588F3A4486
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4F2882CE;
	Tue,  6 May 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S/RWgZqs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9gJh89Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7B2874F8;
	Tue,  6 May 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537640; cv=none; b=F0kkBko21N/M6lD4Rb8hu9yvBgf8E5mqwqmRzLX+L8Nj/0qZMN4popNcoSBVaICFcG5u/8ZtSFB/4pJ8Eyp8PSx3y+V6JF8tVxLkCW5IeHZHtUfj8BCSVmZX0RbIthJX14YxXl9kq2ZBZ7Qaa+rPAFdnsEQ1DEXeJmOoMYiQcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537640; c=relaxed/simple;
	bh=SMktMxyVA9pHw/OCIe/M7qLNpxPWipWn6DNUrCjDHKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rsy8X03OIFZRdtMC5XBV6jWHtzyQ1IibwFMpQJUpEeR371b3Gmeu9QBPRya2GWPiftW1ak05JqZB0V4uFJWQky/efzHpkMl0sAxsu4mC5ndL3QCy6e46VJRbjLon3IadYN/VONVVby0XJ84KE9Cc7ka8agzkm6C+xN4w1+Y4CXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/RWgZqs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9gJh89Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9tkP9w8PA6feYSeXuL+6ZKimpw1y8nB6lmsCULeEz8=;
	b=S/RWgZqs36avsPzKAGc30obD+gVQOmwESckrPx/bCMv3p8wUeSKcxtOieQlvIjdISQrs8A
	3veq+sAw3L5gHHVUcvcjxLo+PIa+RHBd3ndXiOo0HQr0OQcEWSbykjW9yi8hJfcr7Autfj
	mRvouevBiRKgadyJ0TFhMqgjN3ZwTYvX5F8fLYxJFyGX8phKCgP8BVhWCiYvszW2uSFiAu
	0eaTw8dHE3r2ZsCI+X1WuxMahGPvIdUviD1c6av+R/y8JuG0yoAWTIZRWlr74wVsttMiim
	qnGBW/GU+cpdQFlPd+AW7tjw0fa1M1/sr8XImjWrI2UTwIpiL2HFnJPyMN8GDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9tkP9w8PA6feYSeXuL+6ZKimpw1y8nB6lmsCULeEz8=;
	b=j9gJh89QblWKSPE2N/jPQxrDlDeRZQRNpQfU5cxm5iCvhd30r/P2J05Wsnw0dObnGaayWN
	b/viMVLOrW93fcBA==
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
Message-ID: <174653763572.406.3388591124162358804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     487d52c2d837243079114cfbb63b7a3e4553af24
Gitweb:        https://git.kernel.org/tip/487d52c2d837243079114cfbb63b7a3e4553af24
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

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

