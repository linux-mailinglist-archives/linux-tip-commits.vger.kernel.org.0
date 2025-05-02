Return-Path: <linux-tip-commits+bounces-5162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4AEAA6D91
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2247B7A8C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4B22DFB5;
	Fri,  2 May 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SotSIZ9o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7BW7tDi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1C20F088;
	Fri,  2 May 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176664; cv=none; b=l/jpivpiErY4gJVVvByaC5VEBSfOzZdoW++i4yMAhdotqt9rJdYhJUuli42CpCorZCls9YjTykBLUmYg2Sh94HASSUJpnmriwkbxHYjDsGWxkY0L4je9QT69zk7Z1bNNxgKWsle/uBlaEA5uXgqZohyFmS9BUxMcgSfDDCmog/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176664; c=relaxed/simple;
	bh=y6MFv3TZYd2daGGT0Oy5mfeemJAlbXk1cne+X2hWsEs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l3AWEIbdzOr2yskFab/D+M8j/YqIqKV2NrRj8Q69JVa5jFhrz824jk6WHMuvs2ij7ktaPuQ/uzEb4g/fPGs8mfffcBgPtRCbfDMntswaLF5gVi59qi7bBzPgmexji+aBybK6Ksij/CkmrKT8QDepXusAwWBuGm15TmLJ80XC9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SotSIZ9o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7BW7tDi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UldcthdLdT4Iw4IbCKR3f8h/bdLAcbHCLmY91GblJw=;
	b=SotSIZ9oWi17M1lIsz42+FVNcHgFPqLznraaM4CCc39ti3uXPHusaFyPJjISpIn1IW9rSh
	P7tUfhMSi+IBnth7yVgiH6g90tB2zyD5yLJSnc/FuUJ9d29MSyVOYf9q2nrOgg4YnODwCH
	0afmgZ8h18f1xxvKlM9ixO97KFfiWX/smC9XZw3s8nt5AYIFUeMSmmwFoolUyZ+l9GMmEP
	5MaggHHUh9IZRR9+xdYX3UkV+xPmqB3cR3UGxLjuaE//po2FnmisCqgP1MJG0kb2AJuQEk
	Pm+EP6d3LppU4kMitVi/7QssZs7/uYnsMDggnSZWtwUpYunfIoXzMVTDl5uFmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UldcthdLdT4Iw4IbCKR3f8h/bdLAcbHCLmY91GblJw=;
	b=d7BW7tDiiB9FbK3cBp9ibnLG/w4fkpaJxYvXYWIJnfBdtIOfV80wyPKiKo70e+XOQSvFZW
	te8rlJGVmgJQhNCg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/xen/msr: Remove the error pointer argument from
 set_seg()
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-13-xin@zytor.com>
References: <20250427092027.1598740-13-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617665930.22196.4454428302490229307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     2b7e25301c5418059b013c14af9022d892466398
Gitweb:        https://git.kernel.org/tip/2b7e25301c5418059b013c14af9022d892466398
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:36:36 +02:00

x86/xen/msr: Remove the error pointer argument from set_seg()

set_seg() is used to write the following MSRs on Xen:

    MSR_FS_BASE
    MSR_KERNEL_GS_BASE
    MSR_GS_BASE

But none of these MSRs are written using any MSR write safe API.
Therefore there is no need to pass an error pointer argument to
set_seg() for returning an error code to be used in MSR safe APIs.

Remove the error pointer argument.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-13-xin@zytor.com
---
 arch/x86/xen/enlighten_pv.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 719370d..97f7894 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1111,17 +1111,11 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 	return val;
 }
 
-static void set_seg(unsigned int which, unsigned int low, unsigned int high,
-		    int *err)
+static void set_seg(u32 which, u32 low, u32 high)
 {
 	u64 base = ((u64)high << 32) | low;
 
-	if (HYPERVISOR_set_segment_base(which, base) == 0)
-		return;
-
-	if (err)
-		*err = -EIO;
-	else
+	if (HYPERVISOR_set_segment_base(which, base))
 		WARN(1, "Xen set_segment_base(%u, %llx) failed\n", which, base);
 }
 
@@ -1137,15 +1131,15 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 
 	switch (msr) {
 	case MSR_FS_BASE:
-		set_seg(SEGBASE_FS, low, high, err);
+		set_seg(SEGBASE_FS, low, high);
 		break;
 
 	case MSR_KERNEL_GS_BASE:
-		set_seg(SEGBASE_GS_USER, low, high, err);
+		set_seg(SEGBASE_GS_USER, low, high);
 		break;
 
 	case MSR_GS_BASE:
-		set_seg(SEGBASE_GS_KERNEL, low, high, err);
+		set_seg(SEGBASE_GS_KERNEL, low, high);
 		break;
 
 	case MSR_STAR:

