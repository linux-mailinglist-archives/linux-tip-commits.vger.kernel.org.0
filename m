Return-Path: <linux-tip-commits+bounces-5837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC8AD874A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD285189A78C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD3279DB7;
	Fri, 13 Jun 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hc806x/c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNBY0Vsi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F44279DB2;
	Fri, 13 Jun 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805890; cv=none; b=OlDjo9h5fUJ86G45STdM6HxwA7McojK0ZInBUodhxrPRlFLvNhIeQiUNSLT5koGDcvCnkF78p+NxGkSK66gj40ZmuSCD8kWE7HLk+fGD75eKU+T+DvhkmgIc11FN9J9dc3HQoNjbAFVxaof/Zd8Zu+WOMJsZHtSvCjQr80p+7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805890; c=relaxed/simple;
	bh=+hp27uzMfVa0zIe3WW68Yss4qmnl+KhoEv8qvXFQGfI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aJoEPYl8DqqvP13iU2Rvv8hG1oQAqf9b+FYBifZ6ivjSGTSbrVtkpMz74710R16to1NDfqwA4bad6/rSK//6MlvjwpRpE/6KKKIlaidxwpKLyFDMnE+8Zs3mF50qCV65hLiYyvmv+fOyzZFxM+4M+M2ayZms8mDoewvWGUpN150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hc806x/c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNBY0Vsi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 09:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749805886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qZ3rbog1PU0jvG/JDcCla2wMAk/TziTP/l1vKVODhcY=;
	b=hc806x/cwuffVt7lmhRcjROuusk84E5DdOuVpelj0srNd6qu7Z0M8SeTswKockatLP7QOa
	odZN0efsaKVXAC4AB4rbia99OXp3m5ZiltLbASD/esSuoc5q+vLKuqxFLiprLIOONu3hkQ
	V3oDBG2h1H4OPXCW2k9yJtwY1ExI38xezwz6QAf6CA/+nTmVvbYnucknlbfE2sWlt4MHYV
	cxuqAHY0VUWbHC0UrpAC3N+1m/YubNqy2+/zfnMkXfMj9XaAbaeHRgyamV0/eTF0oj2b/r
	c78s7nqiR+692OeWjmHlnhOmwQVCDnDFG2CSo+C6TRl+aYDwG99t4w6bNdUa2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749805886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qZ3rbog1PU0jvG/JDcCla2wMAk/TziTP/l1vKVODhcY=;
	b=QNBY0VsiLy1z9PBd545f9DhUju68L7PntEbtNEX/BDLjSe5KpWvZNYwaC3gUjn+wb+r2u/
	VkwJsyveUj2t9pCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig: Remove the CONFIG_DRM_I915=y driver
 from the defconfig
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980588551.406.17181283015896978758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     c86ec5635d079e62a66e767422ee71a06f930c86
Gitweb:        https://git.kernel.org/tip/c86ec5635d079e62a66e767422ee71a06f9=
30c86
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 10:49:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 11:02:41 +02:00

x86/kconfig: Remove the CONFIG_DRM_I915=3Dy driver from the defconfig

The i915 driver was enabled in the x86 defconfig in 2008 via:

  5cb04df8d3f0 ("x86: defconfig updates")

... basically as part of a slimmed-down distro config.

But we don't really enable AMD or Nvidia GPU drivers,
and the i915 driver adds +10% to the defconfig build time,
as reported by Peter Zijlstra and quantified by my testing:

  starship:~/tip> perf stat --null --repeat 3 --sync --pre=3D'make clean >/de=
v/null' make -j128 bzImage >/dev/null

  | CONFIG_DRM_I915=3Dy
  38.726 +- 0.529 seconds time elapsed  ( +-  1.37% )

  | # CONFIG_DRM_I915 is not set
  34.446 +- 0.659 seconds time elapsed  ( +-  1.91% )

So disable this driver.

Note that disabling this driver has a number of side-effects
on the options enabled in the defconfigs.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/configs/i386_defconfig   | 6 ------
 arch/x86/configs/x86_64_defconfig | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index fac0f57..aeba958 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -158,7 +158,6 @@ CONFIG_NET_CLS_ACT=3Dy
 CONFIG_CGROUP_NET_PRIO=3Dy
 CONFIG_CFG80211=3Dy
 CONFIG_MAC80211=3Dy
-CONFIG_MAC80211_LEDS=3Dy
 CONFIG_RFKILL=3Dy
 CONFIG_RFKILL_INPUT=3Dy
 CONFIG_NET_9P=3Dy
@@ -240,7 +239,6 @@ CONFIG_AGP=3Dy
 CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
-CONFIG_DRM_I915=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_DRM_HYPERV=3Dy
 CONFIG_SOUND=3Dy
@@ -252,7 +250,6 @@ CONFIG_SND_HDA_INTEL=3Dy
 CONFIG_SND_HDA_HWDEP=3Dy
 CONFIG_HIDRAW=3Dy
 CONFIG_HID_A4TECH=3Dy
-CONFIG_HID_APPLE=3Dy
 CONFIG_HID_BELKIN=3Dy
 CONFIG_HID_CHERRY=3Dy
 CONFIG_HID_CHICONY=3Dy
@@ -269,7 +266,6 @@ CONFIG_HID_PANTHERLORD=3Dy
 CONFIG_PANTHERLORD_FF=3Dy
 CONFIG_HID_PETALYNX=3Dy
 CONFIG_HID_SAMSUNG=3Dy
-CONFIG_HID_SONY=3Dy
 CONFIG_HID_SUNPLUS=3Dy
 CONFIG_HID_HYPERV_MOUSE=3Dy
 CONFIG_HID_TOPSEED=3Dy
@@ -292,7 +288,6 @@ CONFIG_VIRTIO_INPUT=3Dy
 CONFIG_HYPERV=3Dy
 CONFIG_HYPERV_UTILS=3Dy
 CONFIG_HYPERV_BALLOON=3Dy
-CONFIG_EEEPC_LAPTOP=3Dy
 CONFIG_INTEL_IOMMU=3Dy
 # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
 CONFIG_EXT4_FS=3Dy
@@ -308,7 +303,6 @@ CONFIG_ZISOFS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
-CONFIG_TMPFS_POSIX_ACL=3Dy
 CONFIG_HUGETLBFS=3Dy
 CONFIG_NFS_FS=3Dy
 CONFIG_NFS_V3_ACL=3Dy
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 09362bc..c20100d 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -173,7 +173,6 @@ CONFIG_NET_CLS_ACT=3Dy
 CONFIG_CGROUP_NET_PRIO=3Dy
 CONFIG_CFG80211=3Dy
 CONFIG_MAC80211=3Dy
-CONFIG_MAC80211_LEDS=3Dy
 CONFIG_RFKILL=3Dy
 CONFIG_NET_9P=3Dy
 CONFIG_NET_9P_VIRTIO=3Dy
@@ -249,7 +248,6 @@ CONFIG_AGP=3Dy
 CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
-CONFIG_DRM_I915=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_DRM_HYPERV=3Dy
 CONFIG_SOUND=3Dy
@@ -266,7 +264,6 @@ CONFIG_HID_PANTHERLORD=3Dy
 CONFIG_PANTHERLORD_FF=3Dy
 CONFIG_HID_PETALYNX=3Dy
 CONFIG_HID_SAMSUNG=3Dy
-CONFIG_HID_SONY=3Dy
 CONFIG_HID_SUNPLUS=3Dy
 CONFIG_HID_HYPERV_MOUSE=3Dy
 CONFIG_HID_TOPSEED=3Dy
@@ -289,7 +286,6 @@ CONFIG_VIRTIO_INPUT=3Dy
 CONFIG_HYPERV=3Dy
 CONFIG_HYPERV_UTILS=3Dy
 CONFIG_HYPERV_BALLOON=3Dy
-CONFIG_EEEPC_LAPTOP=3Dy
 CONFIG_AMD_IOMMU=3Dy
 CONFIG_INTEL_IOMMU=3Dy
 # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
@@ -306,7 +302,6 @@ CONFIG_ZISOFS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
-CONFIG_TMPFS_POSIX_ACL=3Dy
 CONFIG_HUGETLBFS=3Dy
 CONFIG_NFS_FS=3Dy
 CONFIG_NFS_V3_ACL=3Dy

