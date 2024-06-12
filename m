Return-Path: <linux-tip-commits+bounces-1380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2A905CBA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D3B1C22BF9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30784D08;
	Wed, 12 Jun 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpaD6Suy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1ur9UUf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED184A51;
	Wed, 12 Jun 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223866; cv=none; b=eGa7UrHsEmv7P1miKOKO3jhE7XKyG/6XbWHWK4MU8baVJMpGVDDI2s6sfdU+zR2axgrHo3wnj3HWzRpT8jh4/+IcHdCCfMaRC07bn/N/mVYE+WczB1GFvP2UivFWBrXHvvD+yNHKvfqZ0P97ee9TQlZlJP3rHsrM9l5TZQZa/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223866; c=relaxed/simple;
	bh=3Xp2WQTIBaPQkZuUK95la9ovfKSvsB7IAQDJPyJuUXs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ko7pviOJu8Ie6QTefjwuXnccEdU8E55b5MOTB1y/BvubglpsiN3mOf757NjMI4Z9zDD5UZuqddtUkrJmT1b3bqTfYJQXYF354hrT98HO5XJRNRwd6qJPcvQVEuvbOMCT0CsDHAVEVdGm7x8KJShupuC7UCLmL5c/nHHIYJvFBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpaD6Suy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1ur9UUf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uk509uBnwJRFKqhm8eH6qWAk6sMchO1rsPBSFh8LzKA=;
	b=gpaD6SuyFk2uSVbESXPJB4izHXOPz5fcuPehXeOGmZDOQog7QGUSmC9TRuet2q6WH6M9K6
	lXPCEB7R9TxI73h2qbHX9WiaqgNjs8fFTsxCuKNLu8F25wQE2vlHbANXswiL+oLJXq/Q6r
	qzBELFsLCJpPepNlxQFFavNo/iKvSX99CQnmssL9GT7vWIdGRk6rQA2qryqsg3Vg6pUcW+
	PMsW2Pr9nQOSqRkXk1T5nJdJy3Cj8kE5vLfRBzXkt8P3w7YDvVpJYoMYDyGotu/AwRS9uo
	fVFdzd6sikyiOtHzjj6I6PrwnqspPszTtYGRAK6v0b3MQYRe6IdVwxVqDknfNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uk509uBnwJRFKqhm8eH6qWAk6sMchO1rsPBSFh8LzKA=;
	b=F1ur9UUfewrqcHLIEn+b5iyaDytCHfg9zxK8BqotaJ9CE/PacgpYO1GyNx+eGLY+OBnM0z
	X4rABxx+w5T4DDDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] hwmon: (k10temp) Rename _data variable
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-8-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-8-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386297.10875.859676357459803879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     efdf761a83cd390523223f58793755f5d60a4489
Gitweb:        https://git.kernel.org/tip/efdf761a83cd390523223f58793755f5d60a4489
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:13:01 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:40:31 +02:00

hwmon: (k10temp) Rename _data variable

...to address the following warning:

  drivers/hwmon/k10temp.c:273:47:
  warning: declaration shadows a variable in the global scope [-Wshadow]
  static umode_t k10temp_is_visible(const void *_data,
                                              ^
No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-8-ffde21931c3f@amd.com
---
 drivers/hwmon/k10temp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a2d2033..543526b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -269,11 +269,11 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static umode_t k10temp_is_visible(const void *_data,
+static umode_t k10temp_is_visible(const void *drvdata,
 				  enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
-	const struct k10temp_data *data = _data;
+	const struct k10temp_data *data = drvdata;
 	struct pci_dev *pdev = data->pdev;
 	u32 reg;
 

