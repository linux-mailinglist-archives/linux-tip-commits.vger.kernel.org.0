Return-Path: <linux-tip-commits+bounces-2129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A309604D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 10:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069031C2212B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A6199E9D;
	Tue, 27 Aug 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FjXREw3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5G5mLuCT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA9197A92;
	Tue, 27 Aug 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748493; cv=none; b=d0u8RQ4TBPHGg+3kYvh4iBXY2Q9GaNb9rELeNYYe83IsyfMvjJAhSmELkBVj/o9U7Bh3axG39HdD3dnCwuAgm8GqBU4yPVuU5v2vK/+0pBisAZja986i2QWOquoKagYZVoBY1FHV+e5RT6kJyOGscFVav+P6QZmNqFc10knGk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748493; c=relaxed/simple;
	bh=aqmzYt6ZBpGIcsd16z8Od40m3QxPD9MkPs0YSlKEIXo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TgBHVYIc4jKhI+707M6BqpjT1G59Ml4mP/wTLvzIoy6dAJTCGY4rWyZg2TfZtKPJ2nkT4oWZ/BcCrhAfZ0iQx9tBJ1vwuUQEnWSR8rrtTwEKzD1rnyr5KPqcJ63kHD8BLNd0CBVT/kCQHLWrRtkX8kz8jJNEVS9/FyqeSMTGQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FjXREw3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5G5mLuCT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 08:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724748486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1kbo8I6EG5FJgFnoxw43HWT3zevtojYVAJ9Z9QZajw=;
	b=FjXREw3GNODu+g02CQN2Xqe4pqwurNAqEQJIJbuCmfHfNHKnmPPNvSNjDVdDczO075zznW
	eLTIQrog4IFMuLIXt7gQH5558CSaSPmeHaawUzlb1wJM/8hXT2pq/QoRMXu6XfPjsNgghi
	VpEXEviyHUW3fkjfWWAMcKUw5UZRHN6zjD2Rx9qbpTHrQcGxvk7RrrtDctl6LwRo7IHYja
	pbePvlUBPbmKrezpkw0OLKdOqPWnlF/OfzirMmKkAv9Yy2Feih07r8Hy+70FH9y/Hgt7y+
	zlxB4g9yJ24lPw8EULOnJ1e+9wKB1QY+3vEzQWrIkw8y4WWVOq3sFMIh3/rKGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724748486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1kbo8I6EG5FJgFnoxw43HWT3zevtojYVAJ9Z9QZajw=;
	b=5G5mLuCT+FWRNe6MDgkQO5jQE9hu4sFpdSljW0IUz4iljVTyw8jn1tQhkE1VGaO5arD7x0
	Oh7o6Scr5BRn8ICw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Fix user-visible strings
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731150811.156771-4-nikunj@amd.com>
References: <20240731150811.156771-4-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172474848629.2215.14250082751693811062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5f7c38f81df206b370d97a827251bd4bc50ff46b
Gitweb:        https://git.kernel.org/tip/5f7c38f81df206b370d97a827251bd4bc50ff46b
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 31 Jul 2024 20:37:54 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Aug 2024 10:35:06 +02:00

virt: sev-guest: Fix user-visible strings

User-visible abbreviations should be in capitals, ensure messages are
readable and clear.

No functional change.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240731150811.156771-4-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index a72fe1e..3b76cbf 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -114,7 +114,7 @@ static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
  */
 static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
 {
-	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
+	dev_alert(snp_dev->dev, "Disabling VMPCK%d communication key to prevent IV reuse.\n",
 		  vmpck_id);
 	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
 	snp_dev->vmpck = NULL;
@@ -1117,13 +1117,13 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, secrets, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
-		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
+		dev_err(dev, "Invalid VMPCK%d communication key\n", vmpck_id);
 		goto e_unmap;
 	}
 
 	/* Verify that VMPCK is not zero. */
 	if (is_vmpck_empty(snp_dev)) {
-		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
+		dev_err(dev, "Empty VMPCK%d communication key\n", vmpck_id);
 		goto e_unmap;
 	}
 
@@ -1174,7 +1174,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
-	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
+	dev_info(dev, "Initialized SEV guest driver (using VMPCK%d communication key)\n", vmpck_id);
 	return 0;
 
 e_free_cert_data:

