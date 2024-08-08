Return-Path: <linux-tip-commits+bounces-2005-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D294C0F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E72867CD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7DF19049C;
	Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOMosMwe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/bWIWeV8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6218FC8B;
	Thu,  8 Aug 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130505; cv=none; b=iwhul0+/AujPW3VjGIJy0JdFyaYjDQ31h6rdM9ACMsvS0axreFGGiQtgkyLfoMzEoZDHIQS7Ee/EJ8zUhDlDoXNtX/OoBnEcTswP/UkM+VNUoTbwDJtgCiYcg1mzO4/roBvW7KEioCGHVW3HJDVfE+eA887HEkPV2Hicf4/ynSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130505; c=relaxed/simple;
	bh=sG0g6ekVzTCMIXa8He+kVFX7FIgVDP9mtwZefUrCXvA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nn6mnDgB/2PR6AIwrUImQGcIW8qzw5k9TcQ2P/HyrWlbola5NAtHJQIzSfBvW7wlN1230tVDS68IRBU08oqyDLzsaII85+tss+3y1BBdU3as+1dt4+ePM9uYjCwQB7vTbFd8BBppmIZvFsG1q7uzNsj501th9fKb7dwnou3H/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOMosMwe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/bWIWeV8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtOaVZT2Y6ffjfcCw+A+r0YTL28yXXFjTpwdMDTXN0=;
	b=tOMosMweF2tRoc6z+RC7/yZkel7g+PdbRNiK2toVW3bMzy6tVl4ecrr52XRJBV+xYCRuX6
	3bC3waErjI1yhGVfA0XWXrmiUValPbax4xFXnA+9P0wcYjcHVfioZNngoSdEezG0bFHhAl
	Xd6YO4I3yU/nKZo5WEgAw3OmMPYYcBlVSefcNm5GwMP5qKR4sxM7wnZOYGC18To8PPY6aG
	S5AeeTJfwU1CPFuQlvjZbCtLVeBzfiaBMdoAecrEk7V55dlTQG26tV8OrmiAc2gVyuklCs
	vKe+iSoZg15efct9hrPu3j1BMsYEo1UHlF6p+Ajz6zS3B9f3v45TQbIzf2MacA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FtOaVZT2Y6ffjfcCw+A+r0YTL28yXXFjTpwdMDTXN0=;
	b=/bWIWeV8cACKuPfEvuy+Q7bZKjjwSalfR4NQbXLKtLhUA2KJS1GGeUf5MultgLtJad6wEH
	xkrEHW8L5nqQ/FCQ==
From: "tip-bot2 for Zhang Zekun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mbigen: Simplify code logic with
 for_each_child_of_node_scoped()
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240808031552.3156-1-zhangzekun11@huawei.com>
References: <20240808031552.3156-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050191.2215.8129945618349507491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     76bee035c6add05841addc3f31b41cd726b912c4
Gitweb:        https://git.kernel.org/tip/76bee035c6add05841addc3f31b41cd726b912c4
Author:        Zhang Zekun <zhangzekun11@huawei.com>
AuthorDate:    Thu, 08 Aug 2024 11:15:52 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/mbigen: Simplify code logic with for_each_child_of_node_scoped()

for_each_child_of_node_scoped() handles the device_node automaticlly, so
switching over to it removes the device node cleanups and allows to return
directly from the loop.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240808031552.3156-1-zhangzekun11@huawei.com

---
 drivers/irqchip/irq-mbigen.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 093fd42..1291983 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -222,37 +222,27 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct device_node *np;
 	u32 num_pins;
-	int ret = 0;
 
-	for_each_child_of_node(pdev->dev.of_node, np) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
 		child = of_platform_device_create(np, NULL, NULL);
-		if (!child) {
-			ret = -ENOMEM;
-			break;
-		}
+		if (!child)
+			return -ENOMEM;
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
-		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
-			ret = -ENOMEM;
-			break;
-		}
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip))
+			return -ENOMEM;
 	}
 
-	if (ret)
-		of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_ACPI

