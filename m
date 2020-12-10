Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584472D52EC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 05:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbgLJEp5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 23:45:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:12220 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731800AbgLJEp5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 23:45:57 -0500
IronPort-SDR: ER0GPPauokLvRfHQWK8O1pHibQy1ZQjAl1z9pFpWSXPR/nxUQ500fNr8tJyEigc0O7srbe4ltd
 gSYdagD5QOtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="174312771"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="174312771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 20:45:16 -0800
IronPort-SDR: 2y2V7N4MW3og0qRNymZ4HRVE8xs2L1lao2Q7js4rD2E+9eF+qTD4aN4AvxklEwMu4gfePI6t27
 yNwx5Zyr+4HQ==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="364451802"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.210.48]) ([10.254.210.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 20:45:14 -0800
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
 <20201209222328.GA20710@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <343e2fc7-6f64-d1b7-2ea1-cd422596f5be@intel.com>
Date:   Thu, 10 Dec 2020 12:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201209222328.GA20710@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Boris,

On 12/10/2020 6:23, Borislav Petkov wrote:
> And then it didn't apply cleanly:
>
> $ test-apply.sh /tmp/xiaochen.01
> checking file arch/x86/kernel/cpu/resctrl/monitor.c
> Hunk #1 FAILED at 279.
> Hunk #2 succeeded at 514 (offset 64 lines).
> 1 out of 2 hunks FAILED
>
> I wiggled it in but it ended up removing the wrong chunks inc line -
> not the one in mbm_bw_count() but in __mon_event_count() - which I just
> realized.

Thank you for clarifying this issue. It is not a 0-DAY CI issue.

>
> So please redo this patch against:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/cache
>
> Thx.

I will send a patch against branch tip: x86/cache soon.
Thank you.

-- 
Best regards,
Xiaochen

