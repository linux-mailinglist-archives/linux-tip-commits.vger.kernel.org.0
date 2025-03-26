Return-Path: <linux-tip-commits+bounces-4558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625FA711ED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB567A2886
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7119F10A;
	Wed, 26 Mar 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytmNKZEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EH/eiS61"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A351F94A;
	Wed, 26 Mar 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976166; cv=none; b=OpU2B+GL8gcQIvjnf/37YQRmTcdV3kpXz5x5vWeZQfDA4fYmSZEfP4UGwrPSRGV+4XhnqDR3PYPKsaRw2wyvI9OHgdD9dBncqUkwXWtRH4EL9Qisi+pSn9TkdMHGGJj4z/gwOF5+i4yyjyyCMGeXUQDdWQZIF3JBr6BV7032cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976166; c=relaxed/simple;
	bh=aMozfvsJjyZP6wWsr9DBrbLjQ11jjAq6RD+FtbL7AzQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BozpmtYuLrUhu4iLn+KJvM8FlHfQBERKRkdUlBiI+gjETyIX/zUwmqyfIy72maD2z1S8pSSnhsoiUA8TmugsmT0lm95/VrcDPtyusrhql3dDY8bRli8AsSvVax+7KHwPvdRAzpqmP99x04RwXAwjQNAY+HHmZX/cwSKZMMVfYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytmNKZEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EH/eiS61; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 08:02:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742976163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dohyGZo67q9TlCDcBMsbA2FKXHdgnbP20fvoI+5vQg=;
	b=ytmNKZEoQOuG09ZAuhhbKbRbqH/CMFECse25GPu1BU9AJzD0Xg+xNgpYvoU++94Y603HOk
	4bzsIoLsWVVFc2Q13mbMPmB6n3WVzNhPxpOFL0n19FYdbSaxJa/xTyxH/xQ2NAnYmX4p+d
	awWScIjyM9Kf3qjTm5/NC2SqOkxqclcvVfy/UvLJrPz723UoQ3IqtUe8feKV7c4tTQEUXe
	sUhmuM5bo6Sk/OLQimGYTqEFRZ/mqIwnCmXtBiI7D7/MV2Y22SDT9VN2iyKS57hfc7OVwa
	rI0J7bZZO5weeprLGXt4W7vnu6vz/q6YwyvOotti1XFzUSSqCK3oWJO7s2N9Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742976163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dohyGZo67q9TlCDcBMsbA2FKXHdgnbP20fvoI+5vQg=;
	b=EH/eiS61wAlBz3u8Qa/spGRMWwGmIlpNO+TCkwuBX94HM4Gey3wlA43DWWzpXTsDgCIeNN
	kgEY5gtDdRg7W4CA==
From: "tip-bot2 for Vishal Annapurve" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Emit warning if IRQs are enabled during HLT
 #VE handling
Cc: Vishal Annapurve <vannapurve@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Afranji <afranji@google.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228014416.3925664-4-vannapurve@google.com>
References: <20250228014416.3925664-4-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174297615961.14745.3991954793932889948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     e8f45927ee5d99fa52f14205a2c7ac3820c64457
Gitweb:        https://git.kernel.org/tip/e8f45927ee5d99fa52f14205a2c7ac3820c64457
Author:        Vishal Annapurve <vannapurve@google.com>
AuthorDate:    Fri, 28 Feb 2025 01:44:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Mar 2025 08:52:10 +01:00

x86/tdx: Emit warning if IRQs are enabled during HLT #VE handling

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events.

Emit warning and fail emulation if IRQs are enabled during HLT #VE handling
to avoid running into scenarios where IRQ wake events are lost resulting in
indefinite HLT execution times.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250228014416.3925664-4-vannapurve@google.com
---
 arch/x86/coco/tdx/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index aa0eb40..edab6d6 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -393,6 +393,14 @@ static int handle_halt(struct ve_info *ve)
 {
 	const bool irq_disabled = irqs_disabled();
 
+	/*
+	 * HLT with IRQs enabled is unsafe, as an IRQ that is intended to be a
+	 * wake event may be consumed before requesting HLT emulation, leaving
+	 * the vCPU blocking indefinitely.
+	 */
+	if (WARN_ONCE(!irq_disabled, "HLT emulation with IRQs enabled"))
+		return -EIO;
+
 	if (__halt(irq_disabled))
 		return -EIO;
 

