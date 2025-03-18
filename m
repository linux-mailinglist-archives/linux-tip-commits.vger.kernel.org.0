Return-Path: <linux-tip-commits+bounces-4319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD25A67C88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D3819C367B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48098212B34;
	Tue, 18 Mar 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRuG9FSE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6P6YR+3I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DE1898FB;
	Tue, 18 Mar 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324537; cv=none; b=T7eEd2PNvbeegYgOxTyugsxuHUsFINmNTHfX6Cu/qbwKcaiqRptPEGsvzz6iu3r1rUcRT3iUwpB4z6qZmhaehyRQpLDEm8MTHndNIhtyUzlU+6q05gXa/BI+FDBfVXmywE+W61iLFkzeicML4FBvx4q60kWrINCC6IlFfrXh9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324537; c=relaxed/simple;
	bh=T175AQCXpVLRWh0pnxrkYNlK5LXTZtj+QBFR1YkSnlk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LsorH0xC5+gR+7fWhf8CFaJ6hZpUjpdx6LQvrsBjbJ/aROUg5PrN41vj5gxh98oCM5eD/DIK/8TlMO1B/nwEvsckYuI+R/V6bkRlx0URYzzcvyzLNiNrPm41tGPQhnS/Pp5AJpiNQ7BnzhBrUUOBhTNNbLxBYkfY5gvmqjypn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRuG9FSE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6P6YR+3I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QisBsWn0f7Jz8sIf8HYMqaE1Xiro/I8V9ghKdXk5dE=;
	b=jRuG9FSENlx4HMObVaXO7b6SwFr1QLRf6xKh4mKG470KE2tdsGGb5JHrWX5eV9JbGXx2Gc
	n5iwM3bLNSpsnukOnuTGYmYhYeodxW2C48AHmGsYXNedQSl8W5aiONiB3SNwch4tOJRbpw
	RtNE974G5miKkkK4cJ5MjqC9Ps6JIFbhW9FwJzDzoUzCNi7z1h5zlK4iIhmUNJTvC7IfFQ
	recXOc5zC1U3uvdaYKjQyPSx0TJfGmjvp2iD37R6II/ARLoy3c6jMEnDNlvu+yKbGhnYY7
	0/cFHv8FzRzqbYNBmjAgplwkM6LB4wJ6CbfKRYOUGd5OF9+bvyNpN0B/0MBYcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QisBsWn0f7Jz8sIf8HYMqaE1Xiro/I8V9ghKdXk5dE=;
	b=6P6YR+3Iu5dAu5gYZXzA5gaDA93ttujcBiGRzjAyv8Os8j6Di+v5xmED4gzhT0h+plIz4L
	qAzan6k4kqmFkgAg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/mm/pat: Replace Intel x86_model checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-13-sohil.mehta@intel.com>
References: <20250219184133.816753-13-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232406675.14745.16839508278274331287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     aa3e8239d8a2aa4dce2750968964afb5cdd424f8
Gitweb:        https://git.kernel.org/tip/aa3e8239d8a2aa4dce2750968964afb5cdd424f8
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:30 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:47 +01:00

x86/mm/pat: Replace Intel x86_model checks with VFM ones

Introduce markers and names for some Family 6 and Family 15 models and
replace x86_model checks with VFM ones.

Since the VFM checks are closed ended and only applicable to Intel, get
rid of the explicit Intel vendor check as well.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250219184133.816753-13-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/mm/pat/memtype.c           | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 51ea366..6cd08da 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 3a9e6dd..fff9617 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/processor.h>
@@ -290,9 +291,8 @@ void __init pat_bp_init(void)
 		return;
 	}
 
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+	if ((c->x86_vfm >= INTEL_PENTIUM_PRO   && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
+	    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_CEDARMILL)) {
 		/*
 		 * PAT support with the lower four entries. Intel Pentium 2,
 		 * 3, M, and 4 are affected by PAT errata, which makes the

