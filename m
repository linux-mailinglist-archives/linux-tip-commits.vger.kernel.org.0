Return-Path: <linux-tip-commits+bounces-3284-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C93DA1A5E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8774C1697C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456D20F09D;
	Thu, 23 Jan 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVRVP0sx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A8A211293;
	Thu, 23 Jan 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643174; cv=none; b=Zi4sWJkK88MKPoYKSV0WubjsGhCD+tp3A8W/GXtjlg/DP/DqsxlhGDc+Sp6jdPQ4QxCkAIzkdehmnYsO6AO7cy7K/qNTDi3RLyYnncKsSXkilMWSmiRMbHNb0lytRQDehcIvcG3LaHGQ2a0pPVgFeDENG4r4htmp5qM8I6bL1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643174; c=relaxed/simple;
	bh=zEdBM9XB1yIB1/+0puW6nw5nCACCK0i56Yn6xnJZrAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I522P5L/IwlRvUz4gXJeCWpcEWyetWM/o7mbMKm1arTcWucyLmpq/EWpBX3xX8SHYDGCQB5fV5pSe9+EF8FUxgBIV1XD3JQVF3N3pRc+wzlsLRHwLdTyw0VzZwBpu3AY4ZInhNIEJqcpyYAj6Dl4IFILsK7oTqcTlyW503NOe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVRVP0sx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737643173; x=1769179173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zEdBM9XB1yIB1/+0puW6nw5nCACCK0i56Yn6xnJZrAs=;
  b=KVRVP0sxE0UWagsqmk8cHbmOv+zywXLdD60/JISbO2+3kx98WyUz9a/5
   C71XHdS+/nkGNfB0mom1tYuXEDjQsNRraUiTjhvsYhXQczcZuFQBuBbJD
   Yl46FbfV8VSqC1NS4HRDKqefX6TeqJ9192srZA6y0QMBHjHrPq00ExUim
   5FNg517gi9CK4t5Efpn+Gk9BcTLs4ABeWnJtMmYlyuXDRG0d5UeRFMK0p
   edM/8K+VJGTH3Ytg5yUzl5pIGBog5/WiB4qEUGgk3hlWoWmevtGi3BUWq
   mzcM6PrzuIvS7fzkxUlGx7uN1nobhWpRM1cXZSm39kqlSJUXRUKLvlgX8
   g==;
X-CSE-ConnectionGUID: M7vhesZlQP+t3e+tt+VdJQ==
X-CSE-MsgGUID: G7Zayvz0R+yRInzFeEKnXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37349424"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="37349424"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:39:32 -0800
X-CSE-ConnectionGUID: HaOfHpCaSaCckptM0/ISOw==
X-CSE-MsgGUID: ft0kDPk9TXyB9LvKo5qJjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="108082577"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:39:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tayMi-00000004QrQ-3QWh;
	Thu, 23 Jan 2025 16:39:28 +0200
Date: Thu, 23 Jan 2025 16:39:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] hrtimers: Mark is_migration_base() with
 __always_inline
Message-ID: <Z5JUoM70IVkkxo3i@smile.fi.intel.com>
References: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
 <173762985287.31546.13973652433600504292.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173762985287.31546.13973652433600504292.tip-bot2@tip-bot2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 23, 2025 at 10:57:32AM -0000, tip-bot2 for Andy Shevchenko wrote:
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     3ff6e36be060f0a8870f76155e14de128058b964
> Gitweb:        https://git.kernel.org/tip/3ff6e36be060f0a8870f76155e14de128058b964
> Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> AuthorDate:    Thu, 16 Jan 2025 18:07:45 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 23 Jan 2025 11:47:23 +01:00
> 
> hrtimers: Mark is_migration_base() with __always_inline
> 
> When is_migration_base() is unused, it prevents kernel builds
> with clang, `make W=1` and CONFIG_WERROR=y:
> 
> kernel/time/hrtimer.c:156:20: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
>   156 | static inline bool is_migration_base(struct hrtimer_clock_base *base)
>       |                    ^~~~~~~~~~~~~~~~~
> 
> Fix this by marking it with __always_inline.

> [ tglx: Use __always_inline instead of __maybe_unused ]

Thanks, but it doesn't fix the problem:

kernel/time/hrtimer.c:156:29: error: unused function 'is_migration_base' [-Werror,-Wunused-function]
  156 | static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
      |                             ^~~~~~~~~~~~~~~~~
1 error generated.

-- 
With Best Regards,
Andy Shevchenko



