Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1EA3EF7CA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhHRCA1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 22:00:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:56100 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234723AbhHRCA1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 22:00:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="277262502"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="277262502"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 18:59:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="531307668"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.122]) ([10.239.13.122])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 18:59:51 -0700
Subject: Re: [tip: x86/splitlock] Documentation/x86: Add buslock.rst
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org
References: <20210419214958.4035512-2-fenghua.yu@intel.com>
 <162134906278.29796.13820849234959966822.tip-bot2@tip-bot2>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <f1a30c67-2c05-5c8f-df8f-ca82f9bf89af@intel.com>
Date:   Wed, 18 Aug 2021 09:59:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162134906278.29796.13820849234959966822.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 5/18/2021 10:44 PM, tip-bot2 for Fenghua Yu wrote:
...
> +
> +Software handling
> +=================
> +
> +The kernel #AC and #DB handlers handle bus lock based on the kernel
> +parameter "split_lock_detect". Here is a summary of different options:
> +
> ++------------------+----------------------------+-----------------------+
> +|split_lock_detect=|#AC for split lock		|#DB for bus lock	|
> ++------------------+----------------------------+-----------------------+
> +|off	  	   |Do nothing			|Do nothing		|
> ++------------------+----------------------------+-----------------------+
> +|warn		   |Kernel OOPs			|Warn once per task and |
> +|(default)	   |Warn once per task and	|and continues to run.  |
> +|		   |disable future checking	|			|
> +|		   |When both features are	|			|
> +|		   |supported, warn in #AC	|			|
> ++------------------+----------------------------+-----------------------+
> +|fatal		   |Kernel OOPs			|Send SIGBUS to user.	|
> +|		   |Send SIGBUS to user		|			|
> +|		   |When both features are	|			|
> +|		   |supported, fatal in #AC	|			|
> ++------------------+----------------------------+-----------------------+
> +

Hi all,

I'm wonder if using only one "split_lock_detect" parameter for those two 
features is good/correct.

In fact, split lock is just one type of bus lock. There are two types 
bus lock:
1) split lock, lock on WB memory across multiple cache lines;
2) lock on non-WB memory;

As current design, if both features are available, it only enables #AC 
for split lock either for "warn" or "fatal". Thus we cannot capture any 
bus lock due to 2) lock on non-WB memory.

Why not provide separate parameter for them? e.g., split_lock_detect and 
bus_lock_detect. Then they can be configured and enabled independently.
