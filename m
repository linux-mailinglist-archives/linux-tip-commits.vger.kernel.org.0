Return-Path: <linux-tip-commits+bounces-4055-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28CA575C9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29C7189A6F0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB7258CE9;
	Fri,  7 Mar 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOhbXAxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D3258CD9;
	Fri,  7 Mar 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388983; cv=none; b=lmPT/SHEaJdGYcxaygsFyLfHdhqWvp+frQGQGqnreCd/o6HPe2Xdv0wiyFUjDUjI4Ly2GLMr3VE0mVNAN0JRhhktgtJpHAMwqmzabfB51GAv8ztipPkew9mHDRX8OJ4pU+RJUuvbRLwngjZeTVJ84g7vZThlmxo/SYLWNvKk/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388983; c=relaxed/simple;
	bh=zv0WexFPTq1/78gMwzZ++u4C4Tc5n4DsWXo/jzurMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6BBCB767LuPRQ6FdfEa/6JxRmet69l9LBtQQSSGrBFPUh+B32R3PXQCnc9vg9j67VO1YOjPdEqy3V4/lMMINBLsdk/+Z096zHs2XY54dZpZXwLhLrD9Vvg+Omo8NgTRgDz80qlaLNldQPWXnQE4ERgovN417nvmDV95IXFOofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOhbXAxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4B3C4CED1;
	Fri,  7 Mar 2025 23:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741388982;
	bh=zv0WexFPTq1/78gMwzZ++u4C4Tc5n4DsWXo/jzurMcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOhbXAxvVNUMMNS91MEnJ7WhrQZqW3kjFXYpcrKUkLbr/GefYGCoYjTa6jq+o+Qm/
	 JPa3UYsB/3u/PpTH5ncuP7GvJpi+c9yrstRPP3ikCdkxwA0GJ1T49idKbMuJwN0dT/
	 Ognx9pljoUSSPGgt4cIDi80Q9fxVOjy+HLIAZ8TDp32ctBJtUtLkXDjvfwF5abAN5F
	 m4AswzRSbCQNCf/faXaoy0XDyhXBoGEQv2XldrSPV28YYzLgof71Iq6MFjmVeC6NQW
	 uWgBmcaWwG4xUIHeIU3JmVZcu4pTaX7PQb1i3771hAu9aBi8EvlSDn/zE8cHPDsQ77
	 6mB4uWm2ziXeA==
Date: Sat, 8 Mar 2025 00:09:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>, x86@kernel.org
Subject: Re: [PATCH] x86/mm: Define PTRS_PER_PMD for assembly code too
Message-ID: <Z8t8saC5U8qtRxFr@gmail.com>
References: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
 <174125602814.14745.12946945836213678532.tip-bot2@tip-bot2>
 <CAHk-=whTGVy1aaEashu3K49wuG7-hARh02xbAr_hMm3844Ec7Q@mail.gmail.com>
 <Z8oSAQiBvVJ_METQ@gmail.com>
 <Z8oa8AUVyi2HWfo9@gmail.com>
 <Z8skF4rtRzaDL2Ou@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8skF4rtRzaDL2Ou@smile.fi.intel.com>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Okay, just
> 
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> for x86_32 with Clang 19.1.7 and GCC 14.2.0.

Thanks!

	Ingo

