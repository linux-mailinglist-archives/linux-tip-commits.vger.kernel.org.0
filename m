Return-Path: <linux-tip-commits+bounces-3004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD5F9E6BD4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D95287889
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7C206F1A;
	Fri,  6 Dec 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byPraTX+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0JyFhlr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609322010F3;
	Fri,  6 Dec 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480214; cv=none; b=KpmwnCfcfLkEiohCka2Iq8UpMtVae2UciNxvb4dANf2ciW1PwgP+yo6kWakUVjTkr5OCp37xyjvC2mK9EpAEgJ+GAqA8mqvOBt/AIIR/Y5jgmstmLdsELrC6Php41BIL3oCRDExAKDzrw2u3gSyXP2FH+eQ6zzP3htQuHWeseMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480214; c=relaxed/simple;
	bh=20L/CvrsrFGSX/eUQcBEeNXFyop6ti3gq90Z1bNOtW0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fq3uKqer6Tkd2OVSzVwOugQDLAWPc8Lpdx7byFrkj+jTWQAQS+SSjVUB3p5mP+NEwCSt9Rb2tbF7kfnILcKntD9SbwpVbXYtvvDaPrhz0T6WoYAAcwHyFPH2SGH2y6wOHQX8ThaNqq/5o+/YMXFmkdhLx7wCWk4E4XuAfmPfN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byPraTX+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0JyFhlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICHGiFd54SPT+qcv8coRz26XQMYFg1ndEfkK8Q6qYc0=;
	b=byPraTX+ECAnaDEko+42NEuVB0VSnGYCheJxIh8i+At3c8VvKxKTaFigZbVH0cUzpPfpWh
	dYKuL9Lkrf0us57LUWlksyE+l8EbNj3cuo3A747kFVNDKWecdhv+XUneSgOPRIQcTl0DVC
	dEYGt7ZQ0RYiw9NJlRtDjRxTwAPRuh/HVhWuZcg1o6YlNO2x1Fn0IBGfPZ9N3iIhPXv8L1
	OeIlk/VGl68J3Ipt4H8CvYZJl+6e3ME0q6Wv3+7lSCGjE+tP6hqqwzOgq2yoL6Y0tjuE6u
	+slnrtmn26S66qAeD06TBTCUFKQpLIXjdhz7qwgp6wIP1poOwKlSt9mizhnvnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICHGiFd54SPT+qcv8coRz26XQMYFg1ndEfkK8Q6qYc0=;
	b=H0JyFhlrJiyu6V1CoheyOv01+SEHlyj5hT1jGMafN+5MpeWxXqG97Nc22m/dnsdKRpG8Yb
	+CxpvyXlQsSzMpBA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/kexec: Only swap pages for ::preserve_context mode
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-5-dwmw2@infradead.org>
References: <20241205153343.3275139-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020973.412.14181829662601781423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9e5683e2d0b5584c51993908c5d0afa78e613492
Gitweb:        https://git.kernel.org/tip/9e5683e2d0b5584c51993908c5d0afa78e613492
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:10 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:41:59 +01:00

x86/kexec: Only swap pages for ::preserve_context mode

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-5-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index fea650f..ca7f1e1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -310,6 +310,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for ::preserve_context */
+	jz	.Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -324,6 +327,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 

