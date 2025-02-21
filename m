Return-Path: <linux-tip-commits+bounces-3541-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51945A3EF56
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F717A297E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61533201253;
	Fri, 21 Feb 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PX/yWV8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kv9H6G6I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7691E32D9;
	Fri, 21 Feb 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128495; cv=none; b=VpxJGeBVae6MmmiTlq+5t4Ev2wChmzAB/9BeiAP4pcr9tfzZZwWEt6EXxyG69RYvMiWnvVlbYg3QA3nbdv2eLJTmmCn5zoKi8QlSYKKdYi8cO+VbwNAzOm0SvKK56AiMRScCw0lNc7jayZqY7+qvxgJBgt688qeaHJCREximH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128495; c=relaxed/simple;
	bh=7vJvSPQzSoBUQt8xzLFCjrQY/zTadyac/8UlzRw5i0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C4ZYxTjr7DUznnOsbC2AGugTJl5ksT6w8HC5mQXplbiWkGOqzx2LRl2rO9vXd/RF9uR7gcCRVooJHng2t67LnAaafrlNKZqchJ7LVnikIxqiYyGXq0bBhqTwbnP3klEqiRV7OVl5yuWO744a1e5Ox23z+JTFCcdCRrt+vmutHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PX/yWV8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kv9H6G6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:01:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVJ5Nm6RDA6ENWUxFK1qRGqMlGgwpdpHXcgNI6E6azA=;
	b=PX/yWV8/0Hz3iD5NKS19B6Ukzcx/BkHbGmUghZvyn9dAaqhZC4T73HINlZMjX4a16GXQ7y
	JSOJNoVCuJvVcY8/f8SgevE42pS1Qb90iqY7Z1aKwU4XIk0J8rpxAY5vwKHWxc4Vw4G5px
	IK164P3DmExyKMieI+xSqw4pEpEeCg7E16ARyDEeRDV2EMBGN6LsMcegz+otVgCAI3DVcV
	L1WipFSRYPnMSIJOZeruvpZnmSustB9J0U2ZQpAzUdPeboA9aGKoHblBKQYyHJ8Jr6b8FS
	9VEs0sOK8zSzBZul65WgJFixbSWC+Dq/qaziu/jd0tMazaRA9Tfdb4lO37aQew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVJ5Nm6RDA6ENWUxFK1qRGqMlGgwpdpHXcgNI6E6azA=;
	b=kv9H6G6IG1Np4tz3JqRQng3ObtIF7nZwztjoPZMYO0NY6F3uLWU+W+MFyDsw4i9IWV/zjA
	7txACrJnq06BmNBg==
From: "tip-bot2 for Dmitry Osipenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] arm64: dts: rockchip: rk356x: Add MSI controller node
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250216221634.364158-3-dmitry.osipenko@collabora.com>
References: <20250216221634.364158-3-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012849144.10177.5657747381427443590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f15be3d4a0a55db2b50f319c378a2d16ceb21f86
Gitweb:        https://git.kernel.org/tip/f15be3d4a0a55db2b50f319c378a2d16ceb21f86
Author:        Dmitry Osipenko <dmitry.osipenko@collabora.com>
AuthorDate:    Mon, 17 Feb 2025 01:16:33 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:58:08 +01:00

arm64: dts: rockchip: rk356x: Add MSI controller node

Rockchip 356x SoC's GIC has two hardware integration issues that
affect MSI functionality of the GIC. Previously, both these GIC
issues were worked around by using MBI for MSI instead of ITS
because kernel GIC driver didn't have necessary quirks.

First issue is about RK356x GIC not supporting programmable
shareability, while reporting it as supported in a GIC's feature
register. Rockchip assigned Erratum ID #3568001 for this issue. This
patch adds dma-noncoherent property to the GIC node, denoting that a SW
workaround is required for mitigating the issue.

Second issue is about GIC AXI master interface addressing limited to
the first 4GB of physical address space. Rockchip assigned Erratum
ID #3568002 for this issue.

Now that kernel supports quirks for both of the erratums, add
MSI controller node to RK356x device-tree.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250216221634.364158-3-dmitry.osipenko@collabora.com

---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index e553906..89ba0d7 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -284,6 +284,18 @@
 		mbi-alias = <0x0 0xfd410000>;
 		mbi-ranges = <296 24>;
 		msi-controller;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+
+		its: msi-controller@fd440000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x0 0xfd440000 0 0x20000>;
+			dma-noncoherent;
+			msi-controller;
+			#msi-cells = <1>;
+		};
 	};
 
 	usb_host0_ehci: usb@fd800000 {

