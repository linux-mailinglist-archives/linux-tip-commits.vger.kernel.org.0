Return-Path: <linux-tip-commits+bounces-3746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9BA49FBA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CC5176260
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8B146D65;
	Fri, 28 Feb 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQ2de5ST";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T37YpDQo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E31F09BE;
	Fri, 28 Feb 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762237; cv=none; b=T0BT/okfAnLF4MKsVcQL4/kD+veVDbBOK+l4QWsO0H43kYpIiRfnWse1cAYD0VzalImu5GZiOfe3iMBOgOgFnBer+UbnBSFSLhHSYhnPzGW8JwYJhSaionrvHBhp9BhpKGnuvE9gUrptBYsqIvn3G8DtxYzaNTOgBoWA1MvXbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762237; c=relaxed/simple;
	bh=vY6XxSv4jTtvp7PIx/JN+wmTL46kT2u+pcr2Wn8J1II=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YbSA8GHmhO6Ia5aVLmCJo9RSE83sJ+5+at5ZwJ93sNxlacjuGOZPvJPMmmMoObDhoncC3uVyCGb/h0tqYymdTDNm2WjlmUM3Hf2plaw9DQwJdkULg7cMdJB1QLBnMdN02w5lMCAMfNC1o7fwG0hign7yARMrV3sHX7qZTnoVMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQ2de5ST; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T37YpDQo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 17:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740762233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzLWqeNhoTPPQLqEkdofGwdNJYoD9ox6/3zIBrXoBCc=;
	b=uQ2de5ST9Yzs8KQtqPGaVCNixkZruye/FN+uOHy319GD9UYH1rasTKZ3cTP7lSh02MjbF0
	emFBEGYR6SEEIuHO/rMVCLbvpnelGe8Xmh42UWS/yITRywkZ5eYZL0PQR+D6MrOZB9WtGi
	OswPhk5ENvjGosdoM6kmUWyyq2i+Z0dIKgznAoPD1iGf01jiuP+n3kycYCt2kIyLIBuLRe
	KARpKQyon44ed6qx/ncsDMlIqo4lk26CIYNK/LSl1khMnCd7NXPEvhDhPb3qlTZK4xioRJ
	5tSyXvknPe8ioU4aC2w4ncMR3ddPw27xkbM7sYj8wR3SblCvAFgbSdgrgc+eYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740762233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzLWqeNhoTPPQLqEkdofGwdNJYoD9ox6/3zIBrXoBCc=;
	b=T37YpDQotSXdIPfnS5HyQ5sb86mNvbISVWD6Zx+wn9HSvZoK6yAZPv5McdZ6W/TfGf/6jx
	DRNKesycaOQaE5Bw==
From: "tip-bot2 for Kevin Brodsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/headers] x86/mm: Reduce header dependencies in <asm/set_memory.h>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Ingo Molnar <mingo@kernel.org>,
 David Hildenbrand <david@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212080904.2089632-3-kevin.brodsky@arm.com>
References: <20241212080904.2089632-3-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174076223278.10177.10499661618196534085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/headers branch of tip:

Commit-ID:     95c4cc5a585400982ae5b3bf9e3be6de71768376
Gitweb:        https://git.kernel.org/tip/95c4cc5a585400982ae5b3bf9e3be6de71768376
Author:        Kevin Brodsky <kevin.brodsky@arm.com>
AuthorDate:    Thu, 12 Dec 2024 08:09:04 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Feb 2025 17:35:22 +01:00

x86/mm: Reduce header dependencies in <asm/set_memory.h>

Commit:

  03b122da74b2 ("x86/sgx: Hook arch_memory_failure() into mainline code")

... added <linux/mm.h> to <asm/set_memory.h> to provide some helpers.

However the following commit:

  b3fdf9398a16 ("x86/mce: relocate set{clear}_mce_nospec() functions")

... moved the inline definitions someplace else, and now <asm/set_memory.h>
just declares a bunch of mostly self-contained functions.

No need for the whole <linux/mm.h> inclusion to declare functions; just
remove that include. This helps avoid circular dependency headaches
(e.g. if <linux/mm.h> ends up including <linux/set_memory.h>).

This change requires a couple of include fixups not to break the
build:

* <asm/smp.h>: including <asm/thread_info.h> directly relies on
  <linux/thread_info.h> having already been included, because the
  former needs the BAD_STACK/NOT_STACK constants defined in the
  latter. This is no longer the case when <asm/smp.h> is included from
  some driver file - just include <linux/thread_info.h> to stay out
  of trouble.

* sev-guest.c relies on <asm/set_memory.h> including <linux/mm.h>,
  so we just need to make that include explicit.

[ mingo: Cleaned up the changelog ]

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20241212080904.2089632-3-kevin.brodsky@arm.com
---
 arch/x86/include/asm/set_memory.h       | 1 -
 arch/x86/include/asm/smp.h              | 2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 6586d53..8d9f1c9 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
-#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f4..2ca1da5 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -3,10 +3,10 @@
 #define _ASM_X86_SMP_H
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <linux/thread_info.h>
 
 #include <asm/cpumask.h>
 #include <asm/current.h>
-#include <asm/thread_info.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 264b652..ddec567 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
 #include <linux/configfs.h>
+#include <linux/mm.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 

