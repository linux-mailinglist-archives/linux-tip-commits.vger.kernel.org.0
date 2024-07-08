Return-Path: <linux-tip-commits+bounces-1626-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B053C92A193
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0A31F225E5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8B823A9;
	Mon,  8 Jul 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sf4WaCHh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDa33nEK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1380633;
	Mon,  8 Jul 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439372; cv=none; b=gCwOuHzIyyQZx2Gco94RJvn9UGh9V5G8aI1CMHQn2ta6xzayMFmJla72ra9cqMnPH7ZDohBx4pR4FgmfaDbJgnjBr3BxT9R21+4+iBSTVr+qlWwC1u/GsPL7GydjWOkhglW2ljsHBo07ZnQj80x7HRBtcjWd9GZod/pjrm4hxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439372; c=relaxed/simple;
	bh=sjhiZPP5hEETdVbmbHesDb2ubS3Rtp9B6/Oz30zTv6s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cBbuwdbdAjIZGmdnlufoPbU6ezB4GENT+1UYmnjAKaT3VrpR1kUuhvAovlZlN9XQ03SPHNgEMYbi1OkJeVMAo1NcN6DdXZbkRolYRcYk8VdC6T1Vf/IMEPniuHH9B/yunOR3AXeJVWzKlApGgDz36DmS3pZ9r4XtFI6KgWT04Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sf4WaCHh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDa33nEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ/XMjVmVHKW5QlnBSB3C9aH/N5hLUR3z2z139TmPrs=;
	b=Sf4WaCHh5wjKo1IiQWO3DElc8/SK2ITdXVp4vy5B4pTzrZYvy2DLlHMCZ+0u9WZmfnyUoT
	Aa+DWL6J7D1ClaVkJ6bVFURRGVky3rLJAOx1+zbRbMrvjOmyI4vDqtXDRTtgQ9DQxsrr1q
	fRJesD/6Si+W/9/5+t51BE0eNAAajIiOlKnVJOjC6/iYvMH3UZVVjW8P9y0L2Be/VMuUle
	DNEC3JMiOtkx7cibuyBtoBSukYgXf9iKhvdJJbzZdg1AHtfgXfXySGG+LjMVJCrN+I1TSy
	Fyx+tHGNiUdAqiWjLCi0Hj9Jh7cdcHn1ShhFtXC+09HfOAqcxvGZCrOGhzwbPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ/XMjVmVHKW5QlnBSB3C9aH/N5hLUR3z2z139TmPrs=;
	b=cDa33nEKHYVpXBhx03vebkESt+cKkQV99mynEdrTupZoB22fbbLIfx2VIzBJ4NOSMp1PwW
	J/MBlQCOYl37+9DA==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Pass --addresses argument to
 addr2line
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-5-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-5-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936564.2215.10480143326707999309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5b280de46d2bcea9def0dd84b1e86f8b42ca70b9
Gitweb:        https://git.kernel.org/tip/5b280de46d2bcea9def0dd84b1e86f8b42ca70b9
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:35 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:36 -07:00

scripts/faddr2line: Pass --addresses argument to addr2line

In preparation for identifying an addr2line sentinel. See previous work
[0], which applies a similar change to perf.

[0] commit 8dc26b6f718a ("perf srcline: Make sentinel reading for binutils
addr2line more robust")

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-5-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index bb3b5f0..820680c 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -260,9 +260,12 @@ __faddr2line() {
 
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local args="--functions --pretty-print --inlines --exe=$objfile"
+		local args="--functions --pretty-print --inlines --addresses --exe=$objfile"
 		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
-		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		local output_with_addr=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
+		[[ -z $output_with_addr ]] && continue
+
+		local output=$(echo "${output_with_addr}" | sed 's/^0x[0-9a-fA-F]*: //')
 		[[ -z $output ]] && continue
 
 		# Default output (non --list):

