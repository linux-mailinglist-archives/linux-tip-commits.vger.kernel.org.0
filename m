Return-Path: <linux-tip-commits+bounces-4307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C6A6764F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A016A7A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301720E003;
	Tue, 18 Mar 2025 14:26:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AD20DD7F;
	Tue, 18 Mar 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307966; cv=none; b=pr/ydQoy/fDDhM6WCQDpCJ2VHBqmWfXiJmeF+55LEt9jNtbgZCThsvadAFl7sKWgciJat8CWAPXW8kBID3fs2uVXbDvRWlT6BQV1znMxQbkeOsLmAaqWWDzzSWJgnAJSy5g1z6KsIAQgiaY2TfnEpD3vLXVPHWg0cPqVvZ6BnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307966; c=relaxed/simple;
	bh=p5sRv7TnAS1iEbKGPcUy5zaMuYEIEvmCW249qE54jts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLtpeIwkU8nl/4mog6D7no7wu2Kwa2xxWMYsxqiAxS5mMSGAm2IDPFceLBVfNJlDr7SWHOZshduVMciByJwWY1oLEhyCCT2zmZ/qWJyOjuVmICEm8e+KMzQChSc0vjLqezoiiTVY7rp+/PJMDujfpiie2/c+1wtH8nzxXRzu9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FFC4CEE3;
	Tue, 18 Mar 2025 14:26:05 +0000 (UTC)
Date: Tue, 18 Mar 2025 07:26:03 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <avueaoqxm4ntqx4wyslgmnnbj5dmlcystkwf5dv6qm74fugjje@j7i62mfrwypi>
References: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
 <Z9iTsI09AEBlxlHC@gmail.com>
 <Z9leT_0nTlCR-eZA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9leT_0nTlCR-eZA@gmail.com>

On Tue, Mar 18, 2025 at 12:51:43PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > My randconfig build tests found this failure of 36 warnings upgraded to 
> > a build failure:
> > 
> >    vmlinux.o: error: objtool: 36 warning(s) upgraded to errors
> > 
> > One thing that stands out in the config is:
> > 
> >   # CONFIG_BUG is not set
> 
> Here's a different build failure, with CONFIG_BUG set:
> 
>   vmlinux.o: error: objtool: 39 warning(s) upgraded to errors

This last error isn't so helpful, what we really need to see is all the
specific warnings before that.

Anyway this config has the same problem as the last one:
CONFIG_TRACE_BRANCH_PROFILING.

> it was the 6th randconfig - so these failures are pretty high 
> frequency.
> 
> config attached.
> 
> I don't think this change is a wise one so close to the v6.15 merge 
> window...

That's fine, I can post a v2 after the merge window.

-- 
Josh

