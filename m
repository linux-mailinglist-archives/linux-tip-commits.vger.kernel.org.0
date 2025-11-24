Return-Path: <linux-tip-commits+bounces-7513-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1143C805BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 628A94E6CE6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA33043D9;
	Mon, 24 Nov 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxkIVe5L"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC5302766;
	Mon, 24 Nov 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985591; cv=none; b=YjfZc9tJvocL9N7mFTCzATzHfPDRnrxK/eQt9M4cSqXbz+KrIb2O9ZoSxgSuZNGcBCuxgr72ddqN+vbJ9Pvmu8JfTHdQyMZnFr5m8rQdFVL/709ILwH/TbHfQB3op0KBiAjmz/x51BN8d25XCGFxaio6kWeR0uvFfe7EDA/StKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985591; c=relaxed/simple;
	bh=6SIfC8RLk2ce4Gz3AIpUeCai6a4scsL2FbuD9Kjn3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrwMMpQu4LkU4E6vhn6ciGctgWQZ9QCc8HYwbBK0dHozqo0J8WCRtjclkQX/sErw9m4OWsI7RwcUQwoo/LoBz/W0FhGQGSgNHSauWakxJ1FQmGF1pGPV6EVeDd4ucPthWUqyVw7XwCUo6oWCj6u3oJd+HBqi4h8UeFDb1vAaFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RxkIVe5L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=llrDNyAg0cwjjgbtyvpJ0XHESPeCq1kTef2BsRFt2dM=; b=RxkIVe5Lnds8UEya0YbCLPUrQA
	e/NP1MJs6ndMWhX4xHKXRaCWMwXfVwkiNGk/m2o8KjFGJMJQwcjEaHLtfXKnNrn8iAsqqt+4EHdEZ
	AAVMMfa1KbmcP9ov+y616L1nINOmn9JeG6VdSd4vFN82745/du9zVQNrRoJM8V7ILHYSJAd/U5648
	SN7T+kwJWlFbsPM6/ryHzoOWACcWTte8+zPxC0ve/J+w+pSQQU5Nw+kNvmxGtU7653f8nvaiL2w7T
	UxLZz/O0oyfbpIxQKDVpzrbXLn8yWaGQjTb5zcA+xh8oBaFBeyCt12eTnzLU1bGhGxWN8uducZVnO
	6H1ljs3w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNVEO-00000006w98-0Bgm;
	Mon, 24 Nov 2025 11:59:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A42D3002E3; Mon, 24 Nov 2025 12:59:42 +0100 (CET)
Date: Mon, 24 Nov 2025 12:59:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Function to get the name of a CPU
 feature
Message-ID: <20251124115942.GO4067720@noisy.programming.kicks-ass.net>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
 <176398104154.498.14035591969424868341.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176398104154.498.14035591969424868341.tip-bot2@tip-bot2>

On Mon, Nov 24, 2025 at 10:44:01AM -0000, tip-bot2 for Alexandre Chartre wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     afff4e5820e9a0d609740a83c366f3f0335db342
> Gitweb:        https://git.kernel.org/tip/afff4e5820e9a0d609740a83c366f3f0335db342
> Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
> AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Mon, 24 Nov 2025 11:35:06 +01:00
> 
> objtool: Function to get the name of a CPU feature
> 
> Add a function to get the name of a CPU feature. The function is
> architecture dependent and currently only implemented for x86. The
> feature names are automatically generated from the cpufeatures.h
> include file.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Link: https://patch.msgid.link/20251121095340.464045-27-alexandre.chartre@oracle.com
> ---
>  tools/arch/x86/tools/gen-cpu-feature-names-x86.awk | 33 +++++++++++++-
>  tools/objtool/.gitignore                           |  1 +-
>  tools/objtool/Makefile                             |  1 +-
>  tools/objtool/arch/loongarch/special.c             |  5 ++-
>  tools/objtool/arch/powerpc/special.c               |  5 ++-
>  tools/objtool/arch/x86/Build                       | 13 ++++-
>  tools/objtool/arch/x86/special.c                   | 10 ++++-
>  tools/objtool/include/objtool/special.h            |  2 +-
>  8 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
> 
> diff --git a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
> new file mode 100644
> index 0000000..1b1c1d8
> --- /dev/null
> +++ b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
> @@ -0,0 +1,33 @@
> +#!/bin/awk -f
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2025, Oracle and/or its affiliates.
> +#
> +# Usage: awk -f gen-cpu-feature-names-x86.awk cpufeatures.h > cpu-feature-names.c
> +#
> +
> +BEGIN {
> +	print "/* cpu feature name array generated from cpufeatures.h */"
> +	print "/* Do not change this code. */"
> +	print
> +	print "static const char *cpu_feature_names[(NCAPINTS+NBUGINTS)*32] = {"
> +
> +	feature_expr = "(X86_FEATURE_[A-Z0-9_]+)\\s+\\(([0-9*+ ]+)\\)"
> +	debug_expr = "(X86_BUG_[A-Z0-9_]+)\\s+X86_BUG\\(([0-9*+ ]+)\\)"
> +}
> +
> +/^#define X86_FEATURE_/ {
> +	if (match($0, feature_expr, m)) {
> +		print "\t[" m[2] "] = \"" m[1] "\","
> +	}
> +}
> +
> +/^#define X86_BUG_/ {
> +	if (match($0, debug_expr, m)) {
> +		print "\t[NCAPINTS*32+(" m[2] ")] = \"" m[1] "\","
> +	}
> +}
> +
> +END {
> +	print "};"
> +}

Boris just reported that this doesn't work on mawk, since it uses a GNU
awk extension (3rd argument for match()).

Could you please look at writing this in strict POSIX awk?

