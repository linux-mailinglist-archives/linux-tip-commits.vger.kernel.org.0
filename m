Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278903F11CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Aug 2021 05:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhHSDg6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 23:36:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:27242 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236079AbhHSDg5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 23:36:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="238589396"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="238589396"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 20:36:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; 
   d="scan'208";a="521732305"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.122]) ([10.239.13.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 20:36:20 -0700
Subject: Re: [tip: x86/splitlock] Documentation/x86: Add buslock.rst
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org
References: <20210419214958.4035512-2-fenghua.yu@intel.com>
 <162134906278.29796.13820849234959966822.tip-bot2@tip-bot2>
 <f1a30c67-2c05-5c8f-df8f-ca82f9bf89af@intel.com>
 <YR0o5olwUq765pS4@otcwcpicx3.sc.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <aeb1d99d-6651-c0ff-a7bd-f006518080e2@intel.com>
Date:   Thu, 19 Aug 2021 11:36:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR0o5olwUq765pS4@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 8/18/2021 11:36 PM, Fenghua Yu wrote:
> On Wed, Aug 18, 2021 at 09:59:49AM +0800, Xiaoyao Li wrote:
>> On 5/18/2021 10:44 PM, tip-bot2 for Fenghua Yu wrote:
>> I'm wonder if using only one "split_lock_detect" parameter for those two
>> features is good/correct.
>>
>> In fact, split lock is just one type of bus lock. There are two types bus
>> lock:
>> 1) split lock, lock on WB memory across multiple cache lines;
>> 2) lock on non-WB memory;
>>
>> As current design, if both features are available, it only enables #AC for
>> split lock either for "warn" or "fatal". Thus we cannot capture any bus lock
>> due to 2) lock on non-WB memory.
>>
>> Why not provide separate parameter for them? e.g., split_lock_detect and
>> bus_lock_detect. Then they can be configured and enabled independently.
> 
> #AC for split lock is a model specific feature and only available on limited
> (and legacy) platforms. #DB for bus lock is an architectural feature and will
> replace #AC for split lock in future platforms. The platforms that support
> both of them are very rare (maybe only one AFAIK). 

I suppose you mean only SPR supports both.

> Adding two parameters makes
> code and usage complex while only one platform may get benefit in reality.

First, it's about correctness not easiness. Administrator wants to kill 
any user application that causes bus lock so setting 
"split_lock_detect=fatal". But it's possible that all non-WB bus lock 
escapes if the platform supports both feature.

(Yes, the parameter is called "split_lock_detect". It's no surprising 
that it can only detects split lock.)

Second, I don't think using two separate parameters makes code and usage 
complex. e.g.,

   - "split_lock_detect" for split lock feature, it can be
     [off|fatal|warn]
   - "bus_lock_detect" for bus lock feature, it can be
     [off|fatal|warn|ratelimit]

   Of course, kernel can print a message like "split/bus lock detection
   is not supported by silicon" when feature is not available.

Both features can work independently, and every combination can work wit 
h no issue.

Users are suggested to use "bus_lock_detect" to detect all bus lock and 
leave "split_lock_detect" to whatever. Of course they can only use 
"split_lock_detect" while leaving "bus_lock_detect" to off, if they are 
only interested in split lock.

> Thanks.
> 
> -Fenghua
> 

