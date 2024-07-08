Return-Path: <linux-tip-commits+bounces-1621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6492A184
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607AC1F21FDF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68B7EEE4;
	Mon,  8 Jul 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pS7INsXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmOlxvuJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AF7E761;
	Mon,  8 Jul 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439369; cv=none; b=sVsZcsw5iuFjfYJ2XNl8VGjAELWd0lKPXPx0KFW/fUjm367wTq3ayfQ2sod1CZ32UXg0PlaSQ4SLyOIjxlhGHm/ywa+nfNj8qhzrbx6rQpIkA0CGgHSluuKBr9EHjxUHJeexjAWD4ImHtTjy4IO8PeMzQUntTEm7ZNzQvcdW18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439369; c=relaxed/simple;
	bh=BKgMBranHyMlS3hSBaL/ZQ4+gXkZWDigvWX3Bll/Ii8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cygVinkrTKtVWbCMuXCSZuYPCHJB+byZu95IV+Zx/v/I4T4aiOcbEN8v8XvVvmtjN34wQwvryz4E2ToUtLlDjnMvP4oFHZzDzj5j3sPZsYU61c2gBUU6QW6q4/M8k0ECaNOPiQhyy2O4NkLLu08OwmHwDWeRIGmYqg7XpBISzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pS7INsXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmOlxvuJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zA7JFbuj4jq6o6iUBDdmHySvxMe7vNtiMMEsWolvmg=;
	b=pS7INsXwP87fPbD/wv/d4V+sQnOu0fR47dj+JuqwJO4ImcJVMk5riDdR9Iu2PCcyEspw1m
	EIoF82TAwztX946yiHw5PZZBX5gsK9LNmF3EJsobhj+MGe5JuAmflHzrn9V9k28dZlcMwq
	YG9gux+3emSjXyL4fIE70Gf9IfUpf005NUd1sctzTS/79X75hfTj9ujx6C7ZboNQS1sX1k
	uu7VkUmfGoGhM3OEpSbfyKr6vvOYb3gYiIa4R8QZzbQInyTyb/3DQUdp58NOp3VkzSrME2
	54Phm56+FbUkmFVbwj+mo4BqdxIAeC7r/7xs9LlzTe+sdCjDD2eUMLbMRDWpPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zA7JFbuj4jq6o6iUBDdmHySvxMe7vNtiMMEsWolvmg=;
	b=qmOlxvuJ83YBzJIqwYbwoCso7ulnP1gC1Im0zHjaOQyVY604I93yAaZX8ZwEHvFJtOaHTF
	dQevEEsVpyjea0Dg==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Check only two symbols when
 calculating symbol size
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-8-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-8-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936503.2215.12742290480548729781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c02904f05ff805d6c0631634d5751ebd338f75ec
Gitweb:        https://git.kernel.org/tip/c02904f05ff805d6c0631634d5751ebd338f75ec
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:38 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:37 -07:00

scripts/faddr2line: Check only two symbols when calculating symbol size

Rather than looping through each symbol in a particular section to
calculate a symbol's size, grep for the symbol and its immediate
successor, and only use those two symbols.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-8-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6bee..fe0cc45 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -252,7 +252,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 --no-group-separator " ${sym_name}$")
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"

