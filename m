Return-Path: <linux-tip-commits+bounces-4300-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8EA668CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 05:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AA1891D72
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 04:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87F1B87FD;
	Tue, 18 Mar 2025 04:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odpZak+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066DE1AC892;
	Tue, 18 Mar 2025 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273944; cv=none; b=rZOXJvCqBPHjalDm4xyWLiFi252UxU3SKZvHlDTVQtZ+41KZGHuSY+PO/4ZexWMiCJ6hbXrkUgC5B3rb6cDmgTafqLN/X5mi4g6VGPw0SOvc9cquSo7mI3AEwItRooWao8JOxAVmrf6JsVhoHvq0Rv6YzcDPBCMrbxN8h3pyMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273944; c=relaxed/simple;
	bh=B+vT/86V9mxyvQzFyNAlgbeaukbOX4sjGmr2oSxA5i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTcfbqR0/KoY5vvV9FCwPuu0Lr419X9bnI72eJQ65Ui1D65PWtKgS+ZzIdCRqe7JWVAzbVex1kAx3Xjs3UgpL8VCPDBJog5sz+zJDK/1lsUiMXIhPB5J71XuQx2LjjWgHHTcy8ariRzfplDLn99CeD64a7fGWqaIHNR0NYGpYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odpZak+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDEBC4CEDD;
	Tue, 18 Mar 2025 04:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742273943;
	bh=B+vT/86V9mxyvQzFyNAlgbeaukbOX4sjGmr2oSxA5i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odpZak+VSEATpfOXP3hXAueEe0Fmf+5R31SNjvlk6/y1lTv02o/Mm6FN6dgHcp2bR
	 OlKvNVMV3dR+dhxPsWlEvfZzJwAlX5ZXdJeTHejvO1ax1sU1oZBArKNcLn/HZBiJ+0
	 5dmz/WFblHHqXSR0tNUTZzCuxN8rm6qRkyDdNkTurP3TL8Tjn33wfW/EU4C+n7tAUT
	 ndmah0WhbcJt2LR732lAbSJP5MgiW+nsnegx3P9i/oqpQi8K9RZ76Pl3saalw6JIWw
	 +2s7BeVhIJYVHxcxnN6z5Gh1oj7N+ji55nyBrX5mi/ep4YyAVc4SCVJPmXBSZ/Lnf6
	 6VL0axjpZGFzw==
Date: Mon, 17 Mar 2025 21:59:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <zy43nfn4ttzw2j632vn4emgmgrgg5kei4gu2xp2dn2zn6ohzed@exwbw6yvxarp>
References: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
 <6s6qhiuj4ugebglftopde6xm364cxmcni4pexnnx5kojz5qnss@vprcgqepaict>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6s6qhiuj4ugebglftopde6xm364cxmcni4pexnnx5kojz5qnss@vprcgqepaict>

On Mon, Mar 17, 2025 at 05:27:32PM -0700, Josh Poimboeuf wrote:
> On Mon, Mar 17, 2025 at 11:07:23AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     36799069b48198e5ce92d99310060c4aecb4b3e3
> > Gitweb:        https://git.kernel.org/tip/36799069b48198e5ce92d99310060c4aecb4b3e3
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Fri, 14 Mar 2025 12:29:11 -07:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Mon, 17 Mar 2025 11:51:44 +01:00
> > 
> > objtool: Add CONFIG_OBJTOOL_WERROR
> > 
> > Objtool warnings can be indicative of crashes, broken live patching, or
> > even boot failures.  Ignoring them is not recommended.
> > 
> > Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
> > enabling the objtool --Werror option.  Also set --backtrace to print the
> > branches leading up to the warning, which can help considerably when
> > debugging certain warnings.
> > 
> > To avoid breaking bots too badly for now, make it the default for real
> > world builds only (!COMPILE_TEST).
> 
> This last paragraph is no longer accurate, looks like it was changed to
> be off by default.

Also, given all the review comments, should I post a v2 set to replace
the merged commits?

-- 
Josh

