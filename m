Return-Path: <linux-tip-commits+bounces-4832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE4A84EDF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 22:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC903BC270
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD928FFFA;
	Thu, 10 Apr 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itUzQq6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25328FFD6;
	Thu, 10 Apr 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318559; cv=none; b=mzqZxvLgjMHa1+UqEp8oThKxNSklgqg6miiclmqq2P8hktYIBHW2wzdmtBXTFUP9LlqBOk5evb1MMdSR3ZiF5QHrg7jufLh9wUIIO1l6G/W2KKqjcWgBbevJAVvLf++IX5FtNEROqIk3Z4kpBUdnaqiqfqGkFEFeMxwsErpmHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318559; c=relaxed/simple;
	bh=sIP4LMNjW981G+7sUprk0fjwVK1ccUGInZpZiAoDh+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lipWWItFSGPcWVbrEte8leyqMjTr5sFuEhLG5Rk8Z/KTjIURkPUe3GdQJ7aQeg4B1T0a1Cr+Mi6F5qrmu832NBZ2IW8u6q1UgT3RdXwHEBIfEFjdv7RrfANIiyo/KEgxRNYbmM4tyeJgA8i73pjlZKqFl4MvArK9mV3hK5d04V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itUzQq6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E61C4CEE7;
	Thu, 10 Apr 2025 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744318558;
	bh=sIP4LMNjW981G+7sUprk0fjwVK1ccUGInZpZiAoDh+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itUzQq6wRMVynRgOnqug4Eex6T3g3sgv8o2V0EH+ylqu0VsjfDK+svYy3v0n3IE8y
	 kRItzCdpjnWkTot3qoPXzNi1PrqUr4EpZCrNtkXLvGOuNhjHE7oopxIzSG1quEqFKV
	 mlVJ9M7hmvEdFPtyH3267R+Y6PRLX006c+TuGYNDha5xzlx1c7uKC56Uavzv5uIIVH
	 x6enznqtFnAUj2Hdw2QDtX67y/d+P7TScQU/sg+8t8Z9S1ZKip4u5iHhzG/xycagxX
	 14hU1iBmcmbG918YfE8RPGHuLLpCloRXWO3dXdr5C5cejU70DOV198ebORMmoMKZ4f
	 Urat8QlSAZm6w==
Date: Thu, 10 Apr 2025 22:55:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	kernel test robot <lkp@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Fix false-positive "ignoring
 unreachables" warning
Message-ID: <Z_gwWnvENF6DY6h-@gmail.com>
References: <5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org>
 <174426568347.31282.17971680226674649784.tip-bot2@tip-bot2>
 <jd2rsmxvbvawlwwaatx323pzh5on3tjt5cxx5m7icf3sgj6vao@kjmjgb252u3x>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jd2rsmxvbvawlwwaatx323pzh5on3tjt5cxx5m7icf3sgj6vao@kjmjgb252u3x>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Thu, Apr 10, 2025 at 06:14:43AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> > The following commit has been merged into the objtool/urgent branch of tip:
> > 
> > Commit-ID:     8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
> > Gitweb:        https://git.kernel.org/tip/8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
> > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > AuthorDate:    Wed, 09 Apr 2025 15:49:36 -07:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Thu, 10 Apr 2025 08:03:05 +02:00
> > 
> > objtool: Fix false-positive "ignoring unreachables" warning
> > 
> > There's no need to try to automatically disable unreachable warnings if
> > they've already been manually disabled due to CONFIG_KCOV quirks.
> > 
> > This avoids a spurious warning with a KCOV kernel:
> > 
> >   fs/smb/client/cifs_unicode.o: warning: objtool: cifsConvertToUTF16.part.0+0xce5: ignoring unreachables due to jump table quirk
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Link: https://lore.kernel.org/r/5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org
> > 
> > Closes: https://lore.kernel.org/r/202504090910.QkvTAR36-lkp@intel.com/
> 
> Superfluous newline there.

Fixed. Not sure what happened there.

> Also, this probably could use a fixes tag:
> 
> Fixes: eeff7ac61526 ("objtool: Warn when disabling unreachable warnings")

Added that one too.

Thanks!

	Ingo

