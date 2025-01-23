Return-Path: <linux-tip-commits+bounces-3288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF95A1AB1C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695FE1884ACB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628411BBBCF;
	Thu, 23 Jan 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwpegnEK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B68BF8;
	Thu, 23 Jan 2025 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663728; cv=none; b=EMjwF2tWY5Vu7xlhlnkYcsY/vUz0bhvsIwsXZ8gbh8j9VB+rftqC7bDJTtZmpydMmhivw6FKxamoCDg3dQnYcuCqtCJ3zRxRrpqxRzW8Ps0TRtPTuuZkc7ZAYLu2J+1TpUXYud45S0ThylwnAYbRjjcvAcpoPg+2TwDjqTrjLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663728; c=relaxed/simple;
	bh=H4CpWh9DxPYG6bIz9/5+159rqqYXOevSaPYDP/DFkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2Q1L3qlTaqE3k+ryuQNv73l0WPOLSmRvsPEYwrsRi3YkIGNiVWKsg+2lf96KSCWd+d68Gg6/Df8OiXrpo+C4m8ne6CqplSG6pmQCQnkktHnjaMXqU6kN2VR0WyYQ/2337CqlTowqWZIqoAbwOVvyPmarPck5MHdyrWffUcOZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwpegnEK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737663726; x=1769199726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H4CpWh9DxPYG6bIz9/5+159rqqYXOevSaPYDP/DFkVw=;
  b=HwpegnEK9pcvbFM1bJTNjMIrdM1M8GJQ85K6mikpxPSP75FQzGQBk8dU
   lyCgA8qOQjGyDFSxXyYlUcdP+0BHtszfjal85mUVKGFj701U5QXTYMx1j
   ZwFUj57GXOeyHL0QrNmesEnR7Ef4IuD7sRhWZjGdwkjF+CcZNYnF+Dv6J
   iOKjJAyBQJ0jn/1Nxo78BZ6XlvnjlA4L2OqjQ/2O63TITnbw32TDKEWKk
   Xcjbk5LQweY59EYNLwnNPgvdAQ2jUtMMX6mjcDNgE9SZuyrvO5Y7gXkSQ
   xjFh4FNzjxu0+d4+mRuvZiLSCKFUspfwFpO/9RbxEA2/cb7snamqAA7aa
   A==;
X-CSE-ConnectionGUID: 8f0WYh+3TjCFbbJwpM3n+w==
X-CSE-MsgGUID: lunPRV8cSxWFE1CttybE1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38068045"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38068045"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:22:04 -0800
X-CSE-ConnectionGUID: qzOnnU0xRqi70QAGCRHBtA==
X-CSE-MsgGUID: sneeAlMZQjC0VDFl3v3rYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107374392"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 12:22:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tb3iC-00000004bWk-3cUP;
	Thu, 23 Jan 2025 22:22:00 +0200
Date: Thu, 23 Jan 2025 22:22:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org
Subject: Re: [tip: timers/urgent] hrtimers: Mark is_migration_base() with
 __always_inline
Message-ID: <Z5Kk6Gr3-j_6XV8b@smile.fi.intel.com>
References: <20250116160745.243358-1-andriy.shevchenko@linux.intel.com>
 <173765959806.31546.5482091923819197685.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173765959806.31546.5482091923819197685.tip-bot2@tip-bot2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 23, 2025 at 07:13:18PM -0000, tip-bot2 for Andy Shevchenko wrote:
> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     27af31e44949fa85550176520ef7086a0d00fd7b
> Gitweb:        https://git.kernel.org/tip/27af31e44949fa85550176520ef7086a0d00fd7b
> Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> AuthorDate:    Thu, 16 Jan 2025 18:07:45 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 23 Jan 2025 20:06:35 +01:00
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
> 
> [ tglx: Use __always_inline instead of __maybe_unused and move it into the
>   	usage sites conditional ]

This works, thanks!
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



