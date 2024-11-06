Return-Path: <linux-tip-commits+bounces-2774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313879BFA28
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 00:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AD1C21905
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512720E03C;
	Wed,  6 Nov 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1owO+qcd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FyJcGUMs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B69C20E01D;
	Wed,  6 Nov 2024 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935958; cv=none; b=DicRoRcE6L7AZuoMGDo7gn0pHMdaGWjBIOEkRGhGyob3dcW/cixGuJTsNNOKx9ywq8Yd+FqXSVLdTn3u6OrN7gIE/B4EfLIwgioGect3Pt0Ffuz9sQmnQncWuRCZaQ7iuzjoKXKzhKiPeC8k2GckG+5u9BFTIiwvQIi3x1BnQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935958; c=relaxed/simple;
	bh=iLekXIxTGCaLN1xGHaW4hUUcQI9TqDG6KzBH8WgllQI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c5p8uvy3i5MDeVMuElKm6b1gdH9nd7Clj9p2C4fV7DTAwwwflHofRoqS+ey/B4SNzrilPyKqMBwPYcuRoTwLShuhowM1ySnTYtw+6LyyLkvwovkyZNEKRqavPbXflmA2H8ey2MLezjlkRmgQAdmKxxlIpxPIomNadrRINJX8avA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1owO+qcd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FyJcGUMs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 23:32:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730935953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iH9LecWdcxEHKTOU2HoqUYDgosQ9wSYdy6EN8kqMKLc=;
	b=1owO+qcdgs3ORVA/zr9Pcl2T1gDMsnHgjo9ynKCJNyNzjPxUGqfefuXI7Ph4uuARQgZbb3
	EAQEz8BYtVxvWZk4GZ6vpTgt0Q1fJtICHzlr5dcSeANAghYWpZoOLRHgh90Y3V9EcD06kw
	H69tSlnDr2+pJYtfNf0t/seLDK7W99+ZEH+9BCnufOrxNWuxNisYJQrzpiFvaP9iub5LKU
	XgGnqUE77eHnzB6JbtOqEV3p8SqNzd0SCBfsVcOtIsOTs33IB/zoeFusmWRD1BJzeHC6nc
	0LdqzoYyQopq3CdVmAUDMLkeRjoyU2jLGk9o+zaKSi66bL17Zxb6dJtY/gaNZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730935953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iH9LecWdcxEHKTOU2HoqUYDgosQ9wSYdy6EN8kqMKLc=;
	b=FyJcGUMs4eTDmoXGS7pzW5OtjMeOUwN54c0N+7qNXY+TJyO/Jpsiyg7dr9ULpGsGhFg1WH
	PEFQbpQ003tWdHCg==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241031060859.722258-4-inochiama@gmail.com>
References: <20241031060859.722258-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173093595254.32228.11882462267853972393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6da33567c0bf24b642f69b029a2e9ea51fa75472
Gitweb:        https://git.kernel.org/tip/6da33567c0bf24b642f69b029a2e9ea51fa75472
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 31 Oct 2024 14:08:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 00:28:27 +01:00

riscv: defconfig: Enable T-HEAD C900 ACLINT SSWI drivers

Add support for T-HEAD C900 ACLINT SSWI irqchip.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241031060859.722258-4-inochiama@gmail.com

---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393..5b1d632 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -256,6 +256,7 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
 CONFIG_PHY_STARFIVE_JH7110_PCIE=m

