Return-Path: <linux-tip-commits+bounces-6782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBEBCE7A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Oct 2025 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 660EB4E29AC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Oct 2025 20:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC360302154;
	Fri, 10 Oct 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCoQ5TPq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317D26B77D;
	Fri, 10 Oct 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127684; cv=none; b=slpYnR4hgdws9otlwL01Xk7mHfLD1KsHolVBn7fU6ZwZouctwlUdGW4B5N/yBVL8dOhC1yDdCp6fHqQXRxZ9f6q8wGdRsmXi2i2iFyxBE/acy6FokQQhNTGMWy/JQRVpX65labOJphMQXGfIXag8bGjVsLskhDq3IH/pSNh5rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127684; c=relaxed/simple;
	bh=0shdUZWwZ2rOKzDG52dj4mwA0/a4R0r9V5lSWHWhdZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na4CN9n9Cgej7zVwfEm8kelrLjBYniqu0PPx7AKtlq6CfufOKmVwkzd0SJnazF7T2O1lqrst/KBX8Efvxuxf53d9baG8qcmSatNB6k1+zQxKkrsZxJ7E3rVX+1FKxGIfWbpzu4fB3BVBl7vG80EoVGkc7AvaUviB+C+9dCFSVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCoQ5TPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BA5C4CEF5;
	Fri, 10 Oct 2025 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760127684;
	bh=0shdUZWwZ2rOKzDG52dj4mwA0/a4R0r9V5lSWHWhdZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCoQ5TPqdhNA4MP0o2lrMfcp0G3gdlC01EK7KwAGNztT6dEUsWuXpJiIUsgzxiLNv
	 bakmNAFGIKXSUq/H1JPqaCC9/WW4FymGAgrK7P69mDj/7uvZLdhqyM4YeD2LHHShiX
	 3jMijJO8ZezATlVzHYfcnkUmtZGuhgEw+nphfryftafWJwdGzlLrgIPED5P3qkJN/Z
	 sHE9htxLKu2CaXY+jcMV47EeZKKEFG0YAWyPAClPq8Dwv/Nwl+s9HGuQPxd/7QInpm
	 EIDHvAOROQOBX/6tT289qgTrQ2j7RVQaMu7nIkXaTC5p+XGylrLe7C+UmqrZF5hoAf
	 LJuy0wuX+wRWg==
Date: Fri, 10 Oct 2025 13:21:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org
Subject: Re: [tip: x86/cleanups] crypto: X86 - Remove CONFIG_AS_VAES
Message-ID: <20251010202122.GA2922@quark>
References: <20250819085855.333380-2-ubizjak@gmail.com>
 <175577973263.1420.12918884895191770948.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175577973263.1420.12918884895191770948.tip-bot2@tip-bot2>

On Thu, Aug 21, 2025 at 12:35:31PM -0000, tip-bot2 for Uros Bizjak wrote:
> The following commit has been merged into the x86/cleanups branch of tip:
> 
> Commit-ID:     4593311290006793a38a9cbd91d4a65b63cd7b76
> Gitweb:        https://git.kernel.org/tip/4593311290006793a38a9cbd91d4a65b63cd7b76
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Tue, 19 Aug 2025 10:57:50 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Thu, 21 Aug 2025 12:23:28 +02:00
> 
> crypto: X86 - Remove CONFIG_AS_VAES

Hi!  Just wanted to confirm that this is going to make it into an x86
pull request for 6.18?

- Eric

