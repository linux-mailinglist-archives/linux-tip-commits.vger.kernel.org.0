Return-Path: <linux-tip-commits+bounces-1246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D68BF9EC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 11:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95901B24AE6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310276029;
	Wed,  8 May 2024 09:57:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91B7BAE5;
	Wed,  8 May 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162236; cv=none; b=Vkogu2d+sz5zkYy4hxppGfh/MOH7X++z/iEfM5+kT737pa4b2pVsnepSil/JsE8MdI2uxi9NjmHJ2mXfFsEgXVeUaJMoIq90jsvwe16M09rJ0nDTIPxDAMlVG1udfTWYYrhhhzbL8CdRy13rWmS/f5txbfUS4cKswSoZwqLTV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162236; c=relaxed/simple;
	bh=UecIehVVuV7QKjuoSfjMFuJteQdUV6hEq71ZHIeaoHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5PWk0urhN0UJKH0hEZYfPQ9UD4g5yNTj5Nyujtn5JbXWwp+KtsJcm+oGOYonZKMtoQgCi1v+5pb1begwj0Kg0qReC4Q6sFmsCRMdqGofrjtd4WIJpkt2ehpOTbGqeGm6d7HOBqhmkhb47VoYMA+yNvsR0k3n9O5D16VAxF0cm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: MwiFWwKdQg2cswwyacOt8A==
X-CSE-MsgGUID: usYW88xCSla2i9zIpkXKHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11135411"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="11135411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:57:14 -0700
X-CSE-ConnectionGUID: xK14A5pkRseOjSi3NIRvUA==
X-CSE-MsgGUID: mQlF92BzS8yrJ9ckC5YT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="29235860"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 08 May 2024 02:57:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5089518E; Wed, 08 May 2024 12:57:11 +0300 (EEST)
Date: Wed, 8 May 2024 12:57:11 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Levi Yun <ppbuk5246@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, x86@kernel.org
Subject: Re: [tip: timers/urgent] timers/migration: Prevent out of bounds
 access on failure
Message-ID: <ZjtMdx8v051qcNtU@black.fi.intel.com>
References: <20240506041059.86877-1-ppbuk5246@gmail.com>
 <171516154125.10875.14125964308560203288.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171516154125.10875.14125964308560203288.tip-bot2@tip-bot2>

On Wed, May 08, 2024 at 09:45:41AM -0000, tip-bot2 for Levi Yun wrote:
> The following commit has been merged into the timers/urgent branch of tip:

(Yes, I noted above)

..

> -	do {
> +	while (i > 0) {
>  		group = stack[--i];

Looking at this and most used patterns for cleanup loops, I would amend
this to

	while (i--) {
		group = stack[i];

which seems to me an equivalent.

>  		if (err < 0) {
> @@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
>  				tmigr_connect_child_parent(child, group);
>  			}
>  		}
> -	} while (i > 0);
> +	}

-- 
With Best Regards,
Andy Shevchenko



