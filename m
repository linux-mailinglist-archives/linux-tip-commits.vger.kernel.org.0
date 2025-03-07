Return-Path: <linux-tip-commits+bounces-4042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD5A56228
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 09:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A481C3B4C69
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC61A8F95;
	Fri,  7 Mar 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tOH8Cld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgAY7OV7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA571A3162;
	Fri,  7 Mar 2025 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334558; cv=none; b=cTEtKvRLrNDfU5gpBojKYeAGuyZD56o670kHXXBheSM+QtT/lCSBVS4zF9aHPjTs8zIqJ5qhRvBBLMpRrnCVbdPzuDJGp8EFWRNrx5Sm877WV1auHQewxZZdTvb2Uz1vFiuzFwrku15yqWZiKxL696gFp2KUFEGx5Hm/Mx0cDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334558; c=relaxed/simple;
	bh=4vbmOVp9L1Ut7mMb/QngIcoQM3MIh5EpdvtUrMJyG98=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eUrPbTAsn/yJKJOyXs6BM9qADes5xmNU1l6Ung3bdH3FjYRKBAKRdgxdQx6k1U+E/YkrD3jsfXQZquHVpaqyZIKVLzac3rrRcRTPxsn7aMvRasOEHeVFeVXypHCxrLILXoQdTD4tPGzl8yDDoiqiWxvrOv9uQ3oFKkpiA5gfsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tOH8Cld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgAY7OV7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 08:02:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741334554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gic+4k3qcVUsvjzx2gzfn58kQN97RprLHLQdbUevN5M=;
	b=1tOH8CldmLFHshosqNA1CbvS7drhXEmX5BtVeq0J7Rh1iGjnJnyBKTUuDI39tID8fjLzU1
	+V+ykAc+9Zva/boYXK/1tBl8SmeiXSPhVbFHxKiC9admVOHngCQ+8qJ7kZDwH2DJVZypkJ
	AF1QYL01yV7r+wwmke3O9C7gp8qKwG6Y3gphv/hk72lHezTWKmB6ymT86DUOfz2ib176Tb
	BysKElBTiquwZHx7V7kTTUBO209l6NPFzFot+zPPSKtUyJVUlHrursRoHhf/8M8e2/w2la
	dcaqe17IyMk5RItDMW3nRm/3avClN+iVqy3XB0/59RigS64NbWGZnt3uCkUp1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741334554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gic+4k3qcVUsvjzx2gzfn58kQN97RprLHLQdbUevN5M=;
	b=wgAY7OV7lLKuMz6tflWAGCjVSlAH8e2on8u+XdpBj0BOUp8nsa+a2xugb2ZXgzRkZvdiOx
	yCew8vPRJ2+4seDg==
From: "tip-bot2 for Andre Przywara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: irq: sun7i-nmi: Document the
 Allwinner A523 NMI controller
Cc: Andre Przywara <andre.przywara@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307005712.16828-6-andre.przywara@arm.com>
References: <20250307005712.16828-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174133455399.14745.13278977624916567172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     be494a35683e1cbba58395eacb00d4b5cd4e23a3
Gitweb:        https://git.kernel.org/tip/be494a35683e1cbba58395eacb00d4b5cd4e23a3
Author:        Andre Przywara <andre.przywara@arm.com>
AuthorDate:    Fri, 07 Mar 2025 00:57:02 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Mar 2025 08:39:02 +01:00

dt-bindings: irq: sun7i-nmi: Document the Allwinner A523 NMI controller

The Allwinner A523 SoC contains an NMI controller very close to the one
used in the recent Allwinner SoCs, but it adds another bit that needs to
be toggled to actually deliver the IRQs. Sigh.

Add the A523 specific name to the list of allowed compatible strings.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250307005712.16828-6-andre.przywara@arm.com

---
 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index f49b43f..06e3621 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -26,6 +26,7 @@ properties:
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
       - const: allwinner,sun9i-a80-nmi
+      - const: allwinner,sun55i-a523-nmi
       - items:
           - enum:
               - allwinner,sun8i-v3s-nmi

