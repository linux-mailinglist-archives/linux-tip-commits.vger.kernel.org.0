Return-Path: <linux-tip-commits+bounces-5829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A18AD8577
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824023B81E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C0279DBD;
	Fri, 13 Jun 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAVdNTrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="it/gaWFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117D27281B;
	Fri, 13 Jun 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803114; cv=none; b=lGIy2xKOE0KFG8ozTcrSB/Cq6r450akEO6SxD5Cl8h31wiXrz9SkYhRj0E39dJoX5N+a2kJ/AAH9NyLHYPM7kVaJtw0HJoQ17lTVBttgFCfVkiWowMg5RDJ0rb4lucubj2mr4UOVRKB2ls/q0xJVmGGJrtKkk6eNkY4EE8zFies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803114; c=relaxed/simple;
	bh=wav2piYnv3Sv+tLPEfWxEXXTRYsUMgoNsBZVqKOkiek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t7YRIk20j6sCKY3B08L3ZZtyVTQYipWMI3d0+IQw/o9U4aoMckJxKfv4y47NfmCUvuZzItYpbTmAakCEGAWf4f4e8bzngXGx4sQwMPc+WlNFJgkyB0N5BJc5vL395V7GhzRm9ram5GI/G6JwWhQaOenMLWFDhRt8qLXpdpwtlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAVdNTrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=it/gaWFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZnR9AkNtzE1++xetEMzRxOFkGMEsJQCWyurTvqDdRo=;
	b=lAVdNTrUPJ1GDXp082xSGklds5bq40tR9Fpzx1TCt9foTW12gPnQSLf1cWYyOEQ17q6Kyq
	7oe+yUclX5AgYwg7uvefxukXPJv0EInrGxUbiXSoc+9B32eerWiuASGu91luUj8+WLOeqi
	+/80APx7WiCQJGHijlSm27+hnYvrgni41d0Fv1pd3YQK4BRrCrNZykIYe/B7h4NkQchBFA
	NjvfwEsUQOY/Y5qL3aqDPGlNwePaBL/R/ZW5pE8tIa3bcDFsE571G2WfCXxj9q1090AME1
	vR2WIRCglDcyFQlD2PRnYFsv858y2GQVGYbVNbs+StzDiXI+lXlQvWChJNk1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZnR9AkNtzE1++xetEMzRxOFkGMEsJQCWyurTvqDdRo=;
	b=it/gaWFWOJOQBexI+s7MI4s708moExhmrFx/Igm7ccAiBvYK7RcY9WliWedmnpzHMMrlLd
	m533B2vBKpgn/OBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/64: Enable more virtualization guest
 options in the defconfig: Enable Xen, Xen_PVH, Jailhouse, ACRN, Intel TDX and
 Hyper-V
Cc: Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Carlos Bilbao <carlos.bilbao@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 Elena Reshetova <elena.reshetova@intel.com>, Fei Li <fei1.li@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-8-mingo@kernel.org>
References: <20250515132719.31868-8-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310975.406.12171790635962759484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     e76fe3432a2ebca1fb3ec795e5d0191e6c5a1a76
Gitweb:        https://git.kernel.org/tip/e76fe3432a2ebca1fb3ec795e5d0191e6c5=
a1a76
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:02:49 +02:00

x86/kconfig/64: Enable more virtualization guest options in the defconfig: En=
able Xen, Xen_PVH, Jailhouse, ACRN, Intel TDX and Hyper-V

Since the x86 defconfig aims to be a distro kernel work-alike with
fewer drivers and a shorter build time, refresh all the virtualization
guest Kconfig features, enabling paravirt spinlocks, and
enabling the guest support code for the following guests:

 - Xen
 - Xen_PVH
 - Jailhouse
 - ACRN
 - Intel TDX
 - Hyper-V

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Carlos Bilbao <carlos.bilbao@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Fei Li <fei1.li@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-8-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 156e949..df786b8 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -30,7 +30,12 @@ CONFIG_PROFILING=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_SMP=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
-CONFIG_PARAVIRT=3Dy
+CONFIG_PARAVIRT_SPINLOCKS=3Dy
+CONFIG_XEN=3Dy
+CONFIG_XEN_PVH=3Dy
+CONFIG_JAILHOUSE_GUEST=3Dy
+CONFIG_ACRN_GUEST=3Dy
+CONFIG_INTEL_TDX_GUEST=3Dy
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
 CONFIG_X86_MSR=3Dy
 CONFIG_X86_CPUID=3Dy
@@ -128,6 +133,7 @@ CONFIG_NET_9P=3Dy
 CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
 CONFIG_PCIEPORTBUS=3Dy
+CONFIG_PCI_HYPERV=3Dy
 CONFIG_HOTPLUG_PCI=3Dy
 CONFIG_PCCARD=3Dy
 CONFIG_YENTA=3Dy
@@ -168,6 +174,7 @@ CONFIG_SKY2=3Dy
 CONFIG_FORCEDETH=3Dy
 CONFIG_8139TOO=3Dy
 CONFIG_R8169=3Dy
+CONFIG_HYPERV_NET=3Dy
 CONFIG_INPUT_EVDEV=3Dy
 CONFIG_INPUT_JOYSTICK=3Dy
 CONFIG_INPUT_TABLET=3Dy
@@ -198,6 +205,7 @@ CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_I915=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
+CONFIG_DRM_HYPERV=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy
@@ -214,6 +222,7 @@ CONFIG_HID_PETALYNX=3Dy
 CONFIG_HID_SAMSUNG=3Dy
 CONFIG_HID_SONY=3Dy
 CONFIG_HID_SUNPLUS=3Dy
+CONFIG_HID_HYPERV_MOUSE=3Dy
 CONFIG_HID_TOPSEED=3Dy
 CONFIG_HID_PID=3Dy
 CONFIG_USB_HIDDEV=3Dy
@@ -231,6 +240,9 @@ CONFIG_RTC_CLASS=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_VIRTIO_PCI=3Dy
 CONFIG_VIRTIO_INPUT=3Dy
+CONFIG_HYPERV=3Dy
+CONFIG_HYPERV_UTILS=3Dy
+CONFIG_HYPERV_BALLOON=3Dy
 CONFIG_EEEPC_LAPTOP=3Dy
 CONFIG_AMD_IOMMU=3Dy
 CONFIG_INTEL_IOMMU=3Dy

