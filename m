Return-Path: <linux-tip-commits+bounces-4003-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880FA4F9BB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED897A518B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59482040A9;
	Wed,  5 Mar 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9kHzCER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68620409A;
	Wed,  5 Mar 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166299; cv=none; b=eCtoUfvT8SheTDX8qDFecQmtgCmLdTj3ztKVLZVXleqRZPLMub6hhobLeOJ8MaL46Bja/AeUr04Jph2JBnmKOig+XNUmE/c/7VDNHHJ0PhbWZ45DkD4wTADA9skwjXO0mznuharE1XmAapvAiIapaljLNK3qcNlBjblDCE7DVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166299; c=relaxed/simple;
	bh=F+QVHQLvADjnpgZ5vaHKU4ry5ePJ6UYTJ2EnIkrE6cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgcud+MuKvsXm/uPyWUYAgn6ZS2x060Waig45AgDtheJiOaspbNfkgmiw8z0Nt+pF7Af3ZRh0He89BTx8K29dTkEbukkYTcSE/v/PkXMcNjTlbUQ+bP/9tK8qTI+d8hDvSUeaRdwoWiA/qCquy8SRPI9ft3ue+ch7nK8YUMZqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9kHzCER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869D2C4CEE2;
	Wed,  5 Mar 2025 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741166298;
	bh=F+QVHQLvADjnpgZ5vaHKU4ry5ePJ6UYTJ2EnIkrE6cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9kHzCER2IwdXBrxwpN8DbvWz3UYrdYf6mQL/l3U3n17Z10H3WKS6EMAg75QC2zC7
	 YpTUpP5BZ+jsbwSnjlvL4omQlYx+84EWhSyXucNVa+L6SxQQvRitXiN1x/0AeAYi96
	 leAUP9NmuKtNoq5vqGwaOY9uTfJox+zPYF4g5MtZKDgycosbyvH5dYF+Fr+m3jxPWo
	 hVpYay/IlKbDNi1o2YWMIHRwAOyW4b3A6vmj51zjovYiRSG09scWvg0DvFCdwsImHu
	 IRBAHS80cJR4hg0Xi02O7prS4hvbab4nMhkV36ZBQKJ4fBiHOyadff3XXrMuvgXI3/
	 o6Sp55i2Bwj6A==
Date: Wed, 5 Mar 2025 10:18:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/x86: Annotate struct bts_buffer with
 __counted_by()
Message-ID: <Z8gW1rihV0aIp8Oo@gmail.com>
References: <20250304183056.78920-2-thorsten.blum@linux.dev>
 <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>


* tip-bot2 for Thorsten Blum <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     077dcef270361089c322a969b792438b33cfb479
> Gitweb:        https://git.kernel.org/tip/077dcef270361089c322a969b792438b33cfb479
> Author:        Thorsten Blum <thorsten.blum@linux.dev>
> AuthorDate:    Tue, 04 Mar 2025 19:30:57 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 04 Mar 2025 19:58:01 +01:00
> 
> perf/x86: Annotate struct bts_buffer with __counted_by()
> 
> Add the __counted_by() compiler attribute to the flexible array member
> buf to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for a new
> bts_buffer. Compared to offsetof(), struct_size() has additional
> compile-time checks (e.g., __must_be_array()).
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20250304183056.78920-2-thorsten.blum@linux.dev
> ---
>  arch/x86/events/intel/bts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 8e09319..debfc18 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -58,7 +58,7 @@ struct bts_buffer {
>  	local_t		head;
>  	unsigned long	end;
>  	void		**data_pages;
> -	struct bts_phys	buf[];
> +	struct bts_phys	buf[] __counted_by(nr_bufs);
>  };
>  
>  static struct pmu bts_pmu;
> @@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
>  	if (overwrite && nbuf > 1)
>  		return NULL;

Actually, on a second thought:

> -	buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
> +	buf = kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, node);

Firstly, in what world is 'buf, buf' more readable? One is a member of 
a structure, the other is the name of the structure - and they match, 
which shows that this function's naming conventions are a mess.

Which should be fixed first ...

I'm also not sure the code is correct ...

So I zapped this commit from tip:perf/core.

Thanks,

	Ingo

