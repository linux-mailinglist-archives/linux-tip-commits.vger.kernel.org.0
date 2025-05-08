Return-Path: <linux-tip-commits+bounces-5493-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713CAB0172
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1321BC21AD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26360286895;
	Thu,  8 May 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1v5RnU8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fhuYsJO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65F28688A;
	Thu,  8 May 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725235; cv=none; b=lIguLrH9tc/pVVHVuxH2zOwg6Xtil1Zel/9rEGIaUhln+7q6AHDL9w436Q0va2A3XtZ0XJC2HcpQmegc1roADKwAuWXY6eZ/ofLdOkmpV3Qp4C04I2BD233Kqb+aW1/xrEQx/eyBzBp4zQ5wQoWW1UWlm6Y49s6aFJ2KWUfj/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725235; c=relaxed/simple;
	bh=vEvdE28UbdDVQdpKPNldflqMsU8sU0gNE4UdiHYgpuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ki+clZ1d5H3S1+16I/4MzTYi97yKiXlZS+7AM/bSuDDldEpP5v5xSTnbnL+gfpmDp35Q3H59iIskQA+yokoxItKguDJ6R2KiGxDrCaiFtKUoOy8+nxaIC0EkiSzpeaKtplAUoULTumFXbrfYS8ib1VfuQVz9xPbsc7UWTO/ZH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1v5RnU8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fhuYsJO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:27:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hWF8VELxe1fmB6u0bZ2jRFL1B2/8BfqZM9L4cSCSP0=;
	b=D1v5RnU8PKGOofpwErtT9UhjvODnab0EEeWw4Z0DQpzdecZrpUrobrj1zIMTyGRXOQhFMb
	zXWbJ6FaOgeYsqCz60fb/606cg+VdaDpyp4RE7BkoUel+4yJqHVDD/tJV+ECsz4vqhncZx
	+COjxMEvRhxtku5n0ZqWQYDPkWk2Kd+mU6eDd31ZZb6wnBQXDgGbPtygcI6l3OEB97IFqx
	aSLEY3AySv3K1h7egAcOzv8PMphoRKbpTlJ8mTXsnjy7fxBnuY3PPzap+f5G1kxXl1/jKg
	htZCiG1mwZEpvncanzjAk8BjeKK6uRca4kt1OGfso09Dn3ScI/KD9J8gWNiqpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6hWF8VELxe1fmB6u0bZ2jRFL1B2/8BfqZM9L4cSCSP0=;
	b=2fhuYsJO3oYrOTe2WaRdFMHmbh2sgHTy/jNeaW2LZbOHLJ2X0f/FSjLbQ6wRouPJVra7XE
	uk3ObwhxufzoqoDQ==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] dt-bindings: PCI: pci-ep: Add support for iommu-map
 and msi-map
Cc: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250414-ep-msi-v18-4-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-4-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672523050.406.12783420937421276511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     a6aed6b9c79e57064fa8c028662214b436578e80
Gitweb:        https://git.kernel.org/tip/a6aed6b9c79e57064fa8c028662214b436578e80
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Mon, 14 Apr 2025 14:30:58 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:49:00 +02:00

dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map

Document the use of (msi|iommu)-map for PCI Endpoint (EP) controllers,
which can use MSI as a doorbell mechanism. Each EP controller can support
up to 8 physical functions and 65,536 virtual functions.

Define how to construct device IDs using function bits [2:0] and virtual
function index bits [31:3], enabling (msi|iommu)-map to associate each
child device with a specific (msi|iommu)-specifier.

The EP cannot rely on PCI Requester ID (RID) because the RID is determined
by the PCI topology of the host system. Since the EP may be connected to
different PCI hosts, the RID can vary between systems and is therefore not
a reliable identifier.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250414-ep-msi-v18-4-f69b49917464@nxp.com

---
 Documentation/devicetree/bindings/pci/pci-ep.yaml | 68 ++++++++++++++-
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index f75000e..214caa4 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -17,6 +17,24 @@ properties:
   $nodename:
     pattern: "^pcie-ep@"
 
+  iommu-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: Device ID (see msi-map) base
+          maximum: 0x7ffff
+        - description: phandle to IOMMU
+        - description: IOMMU specifier base (currently always 1 cell)
+        - description: Number of Device IDs
+          maximum: 0x80000
+
+  iommu-map-mask:
+    description:
+      A mask to be applied to each Device ID prior to being mapped to an
+      IOMMU specifier per the iommu-map property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0x7ffff
+
   max-functions:
     description: Maximum number of functions that can be configured
     $ref: /schemas/types.yaml#/definitions/uint8
@@ -35,6 +53,56 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 2, 3, 4 ]
 
+  msi-map:
+    description: |
+      Maps a Device ID to an MSI and associated MSI specifier data.
+
+      A PCI Endpoint (EP) can use MSI as a doorbell function. This is achieved by
+      mapping the MSI controller's address into PCI BAR<n>. The PCI Root Complex
+      can write to this BAR<n>, triggering the EP to generate IRQ. This notifies
+      the EP-side driver of an event, eliminating the need for the driver to
+      continuously poll for status changes.
+
+      However, the EP cannot rely on Requester ID (RID) because the RID is
+      determined by the PCI topology of the host system. Since the EP may be
+      connected to different PCI hosts, the RID can vary between systems and is
+      therefore not a reliable identifier.
+
+      Each EP can support up to 8 physical functions and up to 65,536 virtual
+      functions. To uniquely identify each child device, a device ID is defined
+      as
+         - Bits [2:0] for the function number (func)
+         - Bits [18:3] for the virtual function index (vfunc)
+
+      The resulting device ID is computed as:
+
+        (func & 0x7) | (vfunc << 3)
+
+      The property is an arbitrary number of tuples of
+      (device-id-base, msi, msi-base,length).
+
+      Any Device ID id in the interval [id-base, id-base + length) is
+      associated with the listed MSI, with the MSI specifier
+      (id - id-base + msi-base).
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: The Device ID base matched by the entry
+          maximum: 0x7ffff
+        - description: phandle to msi-controller node
+        - description: (optional) The msi-specifier produced for the first
+            Device ID matched by the entry. Currently, msi-specifier is 0 or
+            1 cells.
+        - description: The length of consecutive Device IDs following the
+            Device ID base
+          maximum: 0x80000
+
+  msi-map-mask:
+    description: A mask to be applied to each Device ID prior to being
+      mapped to an msi-specifier per the msi-map property.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0x7ffff
+
   num-lanes:
     description: maximum number of lanes
     $ref: /schemas/types.yaml#/definitions/uint32

