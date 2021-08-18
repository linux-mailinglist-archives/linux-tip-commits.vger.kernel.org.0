Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BC3F082B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhHRPkp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 11:40:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:39016 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237598AbhHRPko (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 11:40:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="214507584"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="214507584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:36:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="521113180"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:36:12 -0700
Date:   Wed, 18 Aug 2021 15:36:06 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org
Subject: Re: [tip: x86/splitlock] Documentation/x86: Add buslock.rst
Message-ID: <YR0o5olwUq765pS4@otcwcpicx3.sc.intel.com>
References: <20210419214958.4035512-2-fenghua.yu@intel.com>
 <162134906278.29796.13820849234959966822.tip-bot2@tip-bot2>
 <f1a30c67-2c05-5c8f-df8f-ca82f9bf89af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1a30c67-2c05-5c8f-df8f-ca82f9bf89af@intel.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Aug 18, 2021 at 09:59:49AM +0800, Xiaoyao Li wrote:
> On 5/18/2021 10:44 PM, tip-bot2 for Fenghua Yu wrote:
> I'm wonder if using only one "split_lock_detect" parameter for those two
> features is good/correct.
> 
> In fact, split lock is just one type of bus lock. There are two types bus
> lock:
> 1) split lock, lock on WB memory across multiple cache lines;
> 2) lock on non-WB memory;
> 
> As current design, if both features are available, it only enables #AC for
> split lock either for "warn" or "fatal". Thus we cannot capture any bus lock
> due to 2) lock on non-WB memory.
> 
> Why not provide separate parameter for them? e.g., split_lock_detect and
> bus_lock_detect. Then they can be configured and enabled independently.

#AC for split lock is a model specific feature and only available on limited
(and legacy) platforms. #DB for bus lock is an architectural feature and will
replace #AC for split lock in future platforms. The platforms that support
both of them are very rare (maybe only one AFAIK). Adding two parameters makes
code and usage complex while only one platform may get benefit in reality.

Thanks.

-Fenghua
