Return-Path: <linux-tip-commits+bounces-6316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11551B31DE0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB0B449FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2C1C3C14;
	Fri, 22 Aug 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k46GbK6L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJ8VeQX9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF31B0439;
	Fri, 22 Aug 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874864; cv=none; b=rGDxpYef1AzJU8LrOUREZ9OIofzeJiTWwdggeq5UokiwmGGGfGf42DMe3iwY4Z8w9UANi0Pu3uhUbues0iDhcnzXmykNHvYjKj+sKgnn/MfeJLX9Y+4cnaNqKMFjcEwOPWgVbcpCz5TmgIEqO/liJZ117o3TpgSOfGcPKvwADKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874864; c=relaxed/simple;
	bh=2k7UVBaHh+96ZLqb3wJljGbZGwElVWy7hb7ixL2ha5o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HFb8J/Jwf/Z23qDGRLuYajPfxhrA3idnPJ7Ql3EdYkyWL2LQItuAqi+rdrlXdbHCZcaBVmzdP4qy9kLUMr1aWmy6eaRRlPcQrRIui16jP9CzTe8G0vnbbsCFYTRBTjOvJ5QGonJMbv6RxYoFMvHJNI97uyJEsHl7qaGJDskoF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k46GbK6L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aJ8VeQX9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 15:00:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755874858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JBzlyEuTXHCzS6IylXDeB55HqDiFONkR9Bh+MQmSWr0=;
	b=k46GbK6L3CHys7abauwn04y2sQHkPx0qDSW/Q9YbHp93P2NXWkBVI5ybF3pTFng34vp8DW
	ZHylCVP18S2uLMMAuHwYZNaIiPf9R5ayZ09CuSZtlpMb3dR2Y5HZBceGzeIDOwD46BfNvt
	Cue4ScQPXeZeEQX5PaOONJaA3WMhHfv2w+lPDc7Pe6cvKW2+13laFn/uSbeC/1Jfj5xJfk
	gL90X1bgnMrYiaJmVmXBHRZ2UyBnR5rTEVgdDvOvWwzg+VQxp890TMK9NeA8fTOdWd5obV
	5DwYEJpA1xy+AdSscwLuYuc+YrhrjPWgc/iVyiQFiU3LxBhU86AjtjgsVLxM+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755874858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JBzlyEuTXHCzS6IylXDeB55HqDiFONkR9Bh+MQmSWr0=;
	b=aJ8VeQX905drzoRUR31JNOlf9MqocfFOmo3C+yGxv7onnELdPZtfgqL+FK+KTNqiuPH85N
	5Svd4t8s4j+gFfDA==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Skip clearing reclaimed pages unless
 X86_BUG_TDX_PW_MCE is present
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Vishal Annapurve <vannapurve@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175587485700.1420.10096238265576778584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     01fb93a363e0583a3ce48098aca5ab9825a5b790
Gitweb:        https://git.kernel.org/tip/01fb93a363e0583a3ce48098aca5ab9825a=
5b790
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 19 Aug 2025 18:58:11 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Aug 2025 07:45:50 -07:00

x86/tdx: Skip clearing reclaimed pages unless X86_BUG_TDX_PW_MCE is present

Avoid clearing reclaimed TDX private pages unless the platform is affected
by the X86_BUG_TDX_PW_MCE erratum. This significantly reduces VM shutdown
time on unaffected systems.

Background

KVM currently clears reclaimed TDX private pages using MOVDIR64B, which:

   - Clears the TD Owner bit (which identifies TDX private memory) and
     integrity metadata without triggering integrity violations.
   - Clears poison from cache lines without consuming it, avoiding MCEs on
     access (refer TDX Module Base spec. 1348549-006US section 6.5.
     Handling Machine Check Events during Guest TD Operation).

The TDX module also uses MOVDIR64B to initialize private pages before use.
If cache flushing is needed, it sets TDX_FEATURES.CLFLUSH_BEFORE_ALLOC.
However, KVM currently flushes unconditionally, refer commit 94c477a751c7b
("x86/virt/tdx: Add SEAMCALL wrappers to add TD private pages")

In contrast, when private pages are reclaimed, the TDX Module handles
flushing via the TDH.PHYMEM.CACHE.WB SEAMCALL.

Problem

Clearing all private pages during VM shutdown is costly. For guests
with a large amount of memory it can take minutes.

Solution

TDX Module Base Architecture spec. documents that private pages reclaimed
from a TD should be initialized using MOVDIR64B, in order to avoid
integrity violation or TD bit mismatch detection when later being read
using a shared HKID, refer April 2025 spec. "Page Initialization" in
section "8.6.2. Platforms not Using ACT: Required Cache Flush and
Initialization by the Host VMM"

That is an overstatement and will be clarified in coming versions of the
spec. In fact, as outlined in "Table 16.2: Non-ACT Platforms Checks on
Memory" and "Table 16.3: Non-ACT Platforms Checks on Memory Reads in Li
Mode" in the same spec, there is no issue accessing such reclaimed pages
using a shared key that does not have integrity enabled. Linux always uses
KeyID 0 which never has integrity enabled. KeyID 0 is also the TME KeyID
which disallows integrity, refer "TME Policy/Encryption Algorithm" bit
description in "Intel Architecture Memory Encryption Technologies" spec
version 1.6 April 2025. So there is no need to clear pages to avoid
integrity violations.

There remains a risk of poison consumption. However, in the context of
TDX, it is expected that there would be a machine check associated with the
original poisoning. On some platforms that results in a panic. However
platforms may support "SEAM_NR" Machine Check capability, in which case
Linux machine check handler marks the page as poisoned, which prevents it
from being allocated anymore, refer commit 7911f145de5fe ("x86/mce:
Implement recovery for errors in TDX/SEAM non-root mode")

Improvement

By skipping the clearing step on unaffected platforms, shutdown time
can improve by up to 40%.

On platforms with the X86_BUG_TDX_PW_MCE erratum (SPR and EMR), continue
clearing because these platforms may trigger poison on partial writes to
previously-private pages, even with KeyID 0, refer commit 1e536e1068970
("x86/cpu: Detect TDX partial write machine check erratum")

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Vishal Annapurve <vannapurve@google.com>
Link: https://lore.kernel.org/all/20250819155811.136099-4-adrian.hunter%40int=
el.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9e4638f..8238503 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -633,15 +633,19 @@ err:
 }
=20
 /*
- * Convert TDX private pages back to normal by using MOVDIR64B to
- * clear these pages.  Note this function doesn't flush cache of
- * these TDX private pages.  The caller should make sure of that.
+ * Convert TDX private pages back to normal by using MOVDIR64B to clear these
+ * pages. Typically, any write to the page will convert it from TDX private =
back
+ * to normal kernel memory. Systems with the X86_BUG_TDX_PW_MCE erratum need=
 to
+ * do the conversion explicitly via MOVDIR64B.
  */
 static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 {
 	const void *zero_page =3D (const void *)page_address(ZERO_PAGE(0));
 	unsigned long phys, end;
=20
+	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return;
+
 	end =3D base + size;
 	for (phys =3D base; phys < end; phys +=3D 64)
 		movdir64b(__va(phys), zero_page);

