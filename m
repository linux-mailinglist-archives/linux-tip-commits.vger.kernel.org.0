Return-Path: <linux-tip-commits+bounces-3540-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C3A3EF58
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80911652EF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C11FBEA5;
	Fri, 21 Feb 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXbaMUDL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufJmfess"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEA1D7E4C;
	Fri, 21 Feb 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128495; cv=none; b=HlLQxkWBg4bzRZUKouYDdeAId2+KTbJ4ikJv5VmeWCeyxH8WT/8X/5sdhw28ZCNmt9fCW3pWWm3WPFSmQ3NHMATp9UG256CLvWGgNosE0k0xjwG36HMC9C/SoNejEuTxxanQ5e66iNIWZZaeXq9SffcW1dHS1a0A1kSP9FTMt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128495; c=relaxed/simple;
	bh=kT5udRDapKFMS8IhebUml1efsR+U/bE17zpkrOTBNoU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E0Knj5Jlaex+cxgwDCyzOI8frIaBBoCO5NFk1c3n/kVZJqiJCM7aznkDtgddhNiQpmLD1dWfsDIQEJie2jEdzABfA5xcBBGaDuGu8crCkkgfECZUa4tIhKBrwM88uaQz6NzbPso5c6ry31FwqgMYuowoTyOjU3As6cDI5smdsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXbaMUDL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufJmfess; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gw2LSNvFUSgulUY37LA0Q6I+Hv9qxcaWsWwq9xRp34=;
	b=gXbaMUDLgNa4fJEKAcsuHzX5uQzIBtBDC3kzWiV4hzvZIZ4qVKdiPKPC7nEEeVBGeUCkXn
	QgIouvSRzNNHSeOPyRzCruJGSvzzjlKdsr3wMiHnx+rQVdrpy1TwKecC+ABkxArpLgQBC7
	+RpT1oiVfJl98rT//EimbFVKM7TmUZwe+5w8HvikbnzObxZzoq48e0sY+DcF0cEHiTxE9W
	IN2fcKTiDI0uzdX8+N23YW0BMYQzWbfVmsCj18PwhyEQSgx+B5F+PDQhpiDmbJVRZQzTDW
	bcpm+5+xXU+Q5C/QhzgiRrgwDHKyv6bM0aeX4AzVJ4owSVKsOk58i5dS0iFRSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gw2LSNvFUSgulUY37LA0Q6I+Hv9qxcaWsWwq9xRp34=;
	b=ufJmfess49nU39W8/xSc6qijO7UWo0PLMkzuH9+weJwzyN/YadyHPC/nmY2PyC1zzY0L7H
	mBLlWjY+1DvQB/BA==
From: "tip-bot2 for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: rockchip: rk356x: Move PCIe MSI to use
 GIC ITS instead of MBI
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250216221634.364158-4-dmitry.osipenko@collabora.com>
References: <20250216221634.364158-4-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012848789.10177.5559847946988418577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b956c9de91757c9478e24fc9f6a57fd46f0a49f0
Gitweb:        https://git.kernel.org/tip/b956c9de91757c9478e24fc9f6a57fd46f0a49f0
Author:        Dmitry Osipenko <dmitry.osipenko@collabora.com>
AuthorDate:    Mon, 17 Feb 2025 01:16:34 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:58:08 +01:00

arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of MBI

Rockchip 356x device-tree now supports GIC ITS. Move PCIe controller's
MSI to use ITS instead of MBI. This removes extra CPU overhead of handling
PCIe MBIs by letting GIC's ITS to serve the PCIe MSIs.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250216221634.364158-4-dmitry.osipenko@collabora.com

---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 89ba0d7..4e730ae 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -969,7 +969,7 @@
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;
 		max-link-speed = <2>;
-		msi-map = <0x0 &gic 0x0 0x1000>;
+		msi-map = <0x0 &its 0x0 0x1000>;
 		num-lanes = <1>;
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";

