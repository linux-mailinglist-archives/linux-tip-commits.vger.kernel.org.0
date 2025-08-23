Return-Path: <linux-tip-commits+bounces-6325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717DBB32BA5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 21:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9446CA0210E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4962EAB9D;
	Sat, 23 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rkwvMks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x06lrit+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1391DED53;
	Sat, 23 Aug 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977427; cv=none; b=tzrNaTY7DsippY8sQmkVF6hBQwa0DVC0ea/AIZaI/cEY7tT3y2AwbX2ydYUoNXf4+UE55HRLEAKD1KHhrVXbuk5MXE4wL9/TR3TWcFrGALStE2b/AI3EWBMJsj6gRegRbhOv7WHF5gf29nbNva5Qf5UJP5xK36HEcetkFVD4J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977427; c=relaxed/simple;
	bh=B1NTPWbIKgQjRwIPrO/fYK2MiZrKrM9Z5Aamygl1bUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YLN6wSyu9jgHr73tW/i8CtGwuLhOUWMdg2fiq5CeC9HpUYFWwYbBIvHeNulkAJiQENLPl3ddmkqwV0gVgx4YNpTpIBFl58cVhWfYE3F8TCcDr/SsrZipjDZlAWTrxX+n0gvduGtBy5p6x8mB3ZrjYQ+MTiCXe25iyMcaiswyTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rkwvMks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x06lrit+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 19:30:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgG2oLZcM+g4MC5ksL4KyiECQ3u/vubbiCsbyv/RBTg=;
	b=2rkwvMksVpFK2JE4qKsFAQwWhVjas/9sb8CNVwXCmDnAJnJIvd4ghUiUl7tBs/974G0F2O
	VSuPQh7n/wGCCBJDcuRPNO5sCJEoA0KFhoEffvT9riyPiGKZP/WmtB2OWB34tg3S97H5pj
	0jbFCzfKee08M9VUN5qoMzCEt4pjO+svHfpaR+6SVgys8hmHM00fo8IB6G6aIvkB7sREkZ
	CBtGHRvw7vP4MRYWjXFla64ZOtrf/G/kXwyb0FIY9aGZ9HSh+8sOuE6NhA04f4PniQyeMU
	PlIEljpg0451iTqisC14QnGvPoZzJiJEHTSPTgSkmWuHenFFBVdEvavjmAf1bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgG2oLZcM+g4MC5ksL4KyiECQ3u/vubbiCsbyv/RBTg=;
	b=x06lrit+3Oc+EG+3hCVINqjiGtOt1+8ix+b24Jyynhkky5z4TEpgz+gR91ItcbPZguNMta
	0I+hpnHRQi8+duCA==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI
 flags for SG2044
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chen Wang <unicorn_wang@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250813232835.43458-5-inochiama@gmail.com>
References: <20250813232835.43458-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597742182.1420.13540606027539180703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7ee4a5a2ec3748facfb4ca96e4cce6cabbdecab2
Gitweb:        https://git.kernel.org/tip/7ee4a5a2ec3748facfb4ca96e4cce6cabbd=
ecab2
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 14 Aug 2025 07:28:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 21:21:13 +02:00

irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044

The MSI controller on SG2044 has the ability to allocate multiple PCI MSI
interrupts. So the PCIe controller driver can use this feature if the
hardware supports multiple PCI MSI interrupts.

Add the MSI_FLAG_MULTI_PCI_MSI flag to the supported_flags of SG2044
msi_parent_ops to enable this functionality.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250813232835.43458-5-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-ms=
i.c
index 2fd4d94..3b13dbb 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -212,6 +212,7 @@ static const struct msi_parent_ops sg2042_msi_parent_ops =
=3D {
 				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
=20
 #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
+				    MSI_FLAG_MULTI_PCI_MSI |		\
 				    MSI_FLAG_PCI_MSIX)
=20
 static const struct msi_parent_ops sg2044_msi_parent_ops =3D {

