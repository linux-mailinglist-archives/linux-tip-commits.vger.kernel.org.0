Return-Path: <linux-tip-commits+bounces-5361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1BAAD980
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A921C21259
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A252235364;
	Wed,  7 May 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IO+Vg+in";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6bsgn/R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE6233704;
	Wed,  7 May 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604697; cv=none; b=rVlWwGdHPS0wOiCARAh9V4M+nGWCnYXqsH7c1jOfXLkVhnBINw87BbG4G5nfGF4Qw2hQdWoCPT+4Op4ct0lhCgkQOD66LPwDwEkWQLmSLlwjd10uYYAUlKeAtEk4fcR7YgLk/R5bl4eXEUtEAHjr5a5sQ0kc2zpcSJ+M1rDqglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604697; c=relaxed/simple;
	bh=YoAw01l0vrGLIR1JlVQ3PNGkVEqX+0QA8wANZfwEDxE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SDpK2mViWiVUQxKCvH+JBBrOlIvXzMIAdlpUmcpDHraIdr5UMcOJrssnydmbCS5SGslYRxVof99UpcsfIfwgBX3mdANhpRqr5O8dt5qUW3GA6xMpSnhE7/gLnpP2kPwwd/sK4Oxnr8LuG0FS1yAg+yt3F0h+Jsdpkc6mqKjMB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IO+Vg+in; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6bsgn/R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezfRK81I3PAivY1ue7uwGC/HVd++cmboXT99k4rIUyg=;
	b=IO+Vg+inae87M7nFRXtFwGEveEb10vz4o0NTUexi7YVbO7/O+k/tKBJGWSACketp7JyUba
	weT1lEFLChhf/6sYKX1A8z3IGVd7bXGQePjtuBlpGdwUSazI/7XRxY9JPYPFxjg53nKWaY
	+JL/oJ1QOJ53M9pWkcmX1c1XArpYl1yrHetdc1ilzyY4XHrzIKvBr4NqSJ31VogoXPQ4tN
	IyUiAt048FVv3dYgXFM7FzIm1GGgTLD2GCSAeqRKLqllsWRSEadxPflBL2ugKbbRRmMusg
	aF3VELzNc97WYU6UKELGikYLdQMrhQfURwFa/zFSC+XaS1JxUD1jsn9yLzYH5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezfRK81I3PAivY1ue7uwGC/HVd++cmboXT99k4rIUyg=;
	b=h6bsgn/R+N9GpjnLALUfBi4RMmiORQL1j68ZN7PKK5a9rXfTcXw0cwNl1TsIG+xyRMfYMu
	wZEhfwJvBngRSACg==
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
Message-ID: <174660469067.406.15704701390235550501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     cd9910d1e871c40184b2187464661873bc8733aa
Gitweb:        https://git.kernel.org/tip/cd9910d1e871c40184b2187464661873bc8733aa
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

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

