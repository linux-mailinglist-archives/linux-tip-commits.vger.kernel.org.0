Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4CE435452
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJTULB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 16:11:01 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:17825
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231143AbhJTULB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 16:11:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlL8r71Cjw793bUl3MBRMDWUl7Jkx1ezycyDgDGKqcM8eo4FAQyqy2XT+S5fmy2rtE0MmWvyv5s+s1DPgIRKLhHo9wXPbhOye29Kzc8vgVzS3Rkaus5f8uzjN5rDsrabWsqUkuOmcudPGWEIxuAxbOaHKoxP9Kc/plQ1zGlV0yOsTaH/SGU1l8SCTS1ifWTOtVCcXM50gtz1fuRu3qtukT4TPUzYsNGgeaICYie4i9xzg2o9wOEsd/d+E3amAVI8I75DKsK3cSG8mbppK1OY2edgRX9SZedq1TkprdhP5J/xLiZZXmiQgP/nhsU4z21g15bSxrk9ySReoryoSer6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c95CBWEShlbXdz5ppBt5MFQyUryWjzloc4hRnTxb2no=;
 b=ZCg5HScoi97bAzwns88kFdy8hfuDkqphtUdxKt6JeTLGgLHIwAPm8LzN6jlPiUjqmrMKAVM49oQTm4PlaztnoPVQSjrMbzN4fiNQ+D0EE6UnLqn6YusjmLNduk+i4CEVb43YLkGqi4eL8XeBGK+/eyWB5XLlTeBBeJJcP028IWODIOHu63OAiF6ocW7B5Jf2FLrBHnJ0SvOCJAfCJraGIUn2aQsquds7ZDCjz2YbDA2sJ2d4dD3USfBmqv7S60vOal4CKIQM4XpQugnqpFw9hDodDNKj53v2Q9im3GSP5y1k0Ndb9wRrKb2xDf3aWI+1t/ifbDyV66/NQOz2+wy0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c95CBWEShlbXdz5ppBt5MFQyUryWjzloc4hRnTxb2no=;
 b=Uw5d3y3/BWjDr9fn0ZS5pzxXJUwWdrFOD1L2Ijeh93NYZGDN8ixQTueNKFwRX9vVBIsVHHf5eiL/Sn5RSdOqwVShrlMALcKDepWpOpVJMGh81aGruun4eEfgZpxcZ5s+FeQWaC6GWfCEVOIHjaUUPABxg9HM4kZklyfCGcYubK0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 20:08:44 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 20:08:44 +0000
Subject: Re: [tip: sched/core] sched: Add cluster scheduler level for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>, x86@kernel.org
References: <20210924085104.44806-4-21cnbao@gmail.com>
 <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
 <9e7b0c92-5a3b-8099-8c69-83a9d62aced4@amd.com>
 <20211020195131.GT174703@worktop.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <df3f2127-47be-cfd6-9c19-5f0aacf014f4@amd.com>
Date:   Wed, 20 Oct 2021 15:08:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211020195131.GT174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:610:e4::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 20:08:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b1d960-4c13-47fd-768d-08d994056af3
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:
X-Microsoft-Antispam-PRVS: <DM8PR12MB542987349ABC405B7EBAB498ECBE9@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFOS43+VISclZW9Rh5yrlIiomyh/Ch59hdzls4LxawnSXyuv1PdXITl/9eHb67cA9Ony6CuD/g/HTXvzbvlfvDOHLfqSfHk1Eiq0uTsQcGYlGEEeUAHTiuI9IaNCXd4X91EJTAigQBOgWxl8Uv5GB4LxHr6JwfFQ3KTacEjSIwzF+DQhKQLgBPcvok+k674I4AiB69IfajEORyE3sYiqo7NJGjsoM1C5bYeUri3ip5/46i/Bvi0IFZeLW6LthvjfhurEFyJ5k/IdMDSeMUnjj8zU7XU7O02eR1DX3W4+Ox4k9eYL3MRdNJowBNt6l5s6QCErf4/FFh6hPfQ2WXVwI8H0pB68oqTaTRd3GzMpcW16ldZsqXqKfcFVsb0bxRa3JNjXsyVzZH941Mqi3I/HR2bJGPQ77v3CaLntnQIUKFpAxtydgLXeIOnHZl/d6wLzTGk80s66DD1KEgptgyL82116a4UWQDyncWpmW1vGDJMnqiG23gXk14UWgWpukCZiVhf016iFPKfrPzn1zTODO98yXG7jPA86aaiQ+emiKYT7r4uFY7iiWRDsBVnuK5sUM3wWClaus3Y/FxN/vKPdxWpnOI/iNBmMxPVnihCqlLFG265VDbrtDhuMMMEbbw4Om/xmMsUaSoxvmeNJQklaN9nCB5QDPgBUc8yh1Rx2LHrc6lHn07wOOdp3yz2tNh/Dn9PGOt3fUS1PRwVrB2oHmmU3o/3TOdH3jIGfgZG8jizTJ2LGbkdbzEpql/EwYY0S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(4744005)(508600001)(8936002)(6486002)(2616005)(38100700002)(4326008)(66556008)(5660300002)(31686004)(316002)(26005)(2906002)(956004)(66476007)(53546011)(66946007)(54906003)(6916009)(16576012)(186003)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1odTROYmZFeXNIdFhXbFh5dkphU2EvYVltTWdOcU1TTUR5ajZYZVVMY0tK?=
 =?utf-8?B?MlU5U3RvNWNCNHBHQkhzbklCc21GZHQzSmVPTTNMSmkwUG9mVkplS1A5bFZs?=
 =?utf-8?B?VDdiRXNxTUpsbldQaUdvUHJLa25RMzYyNmh3STFKU0RBdmtYU3NwSHNXK2hu?=
 =?utf-8?B?OFNxNXRwbTA4Y3ZMMWkxM3pvSk9tNE54bFUrN0phMW9RRm1yeXpXK1c2MmE1?=
 =?utf-8?B?N2VZZnZGcnJBSUJnWEtNU0dyM2pVRlZLTEViMXl2OU1OaVkyeWN0R0RrNXEx?=
 =?utf-8?B?VFkybmhybUp0RVo2cStkTUZGaFVaejhTNWsxNDNMRzdVNzNxZEw0VmtqeFNQ?=
 =?utf-8?B?eGc0cHdnM0MvdDl2RFF2WFRhYWJVa29FUFRnbVg1TkdNbjJFTmNTMDhWdlJE?=
 =?utf-8?B?ejFiQVlad3Iva0I1QkV5a2tOTkg3QmlhY25Gd0RlQmQrdXk1Q1pQQW1kc2NH?=
 =?utf-8?B?UyswVisyaGIwRUdmSGt1aTZVcnErbFBQaXNoUU1XUWRMSE0vZVlnRkZBOERw?=
 =?utf-8?B?YWREcWZsZmxUdjRHbW9PenV0VUhWdUZKRFE0YndvMkxMWTZtV0VMSExlM25R?=
 =?utf-8?B?L0R6dFZqREZ2dGVQcnhGT0ZFMitocVE0Z3VSQ3d0Q053Z2VnT2N5Qml3Zk1i?=
 =?utf-8?B?ZStmeHJkZ0VOV1RnMTZWWG5QRnlxc2JWTk03eTlFdWxBU0VIdmY5MFZqU2Q3?=
 =?utf-8?B?azNwc3dFQzNVRjlwL1V3dTNiV0hWUFB1a0hHUTBpeW80d1RXTVF2QWwyYkk2?=
 =?utf-8?B?azNiM3BlTzExdjN5TEJrL1V5UlUzYmJDWVpNck92ODBhV2R4ZGFISzNrd05a?=
 =?utf-8?B?SEJGUUU0TXRjSDBmdUFDZUlyenh5SkxLVWs3aVNxMi9XTnR4TnROcFdyVUFz?=
 =?utf-8?B?RW02RlZOQkR5blpCSEd4R29yQTU0S1greTVDSTZVMzhTekNLNTUxREZ3dFBO?=
 =?utf-8?B?emRENWVLNjRqY2V6cTI5NDYxNjVia1oyTGRKL21hWXpSWDVwYktZRlFKU2t0?=
 =?utf-8?B?OFpZQVIyRUM1Wkw3TytiTm5RM05lWXZvWmVUaC9mT2tHOTVQZk9pVmNWaFJL?=
 =?utf-8?B?UGxFcDFwV25hcS9tQ1A1VEk1TFREM2hzTTNhU1JrMHJHK0NNa2RnQ0hEYlJ5?=
 =?utf-8?B?N2dxTW9ZUUhlMjdJNzZCLzI1ZldoaHNFWHQyQTlDOXFaMFJvWDFHWlFiMnMz?=
 =?utf-8?B?M01Oa2t1U3l5UW9HRktVSFF2RXhZcVZJVG9jMkJaSW1kVmQ0ODZ6REIrK1lG?=
 =?utf-8?B?TzIxRWcwVVRGdE5OcXI5bzNCclVsNHdEVmlzQlBNVEgyQmptV2lCU2paYUll?=
 =?utf-8?B?bmVDR0IrdW5tQVpobFN5NVB4UE9FUVhWREFkSlVpdkF0Y0c4aWNPWTUvcjJ5?=
 =?utf-8?B?Y1lySFNGYXNtNlpIM3hiNTI4V2dxODUyYmJ6VzM4cU9UTTl2YjRvcUk0bzFx?=
 =?utf-8?B?WUtNY3ZKUitSZ1R2cWRCditmQXBKUHppSEEwMzVaOXM4bVFYa1JQd0sxYUJn?=
 =?utf-8?B?THYxeldCK0orUTZnL2g3Z0NDSVdhRGF5TFFyY0IwOHhtUEt2SHR3T3JGN2NF?=
 =?utf-8?B?akt6aG8vbTEvMDBPMnBXS2lwRHVuQUFOMDBsZWY5SmhsRVpVYTF4SU9YY3pp?=
 =?utf-8?B?RTdNc1NnWE5LUkgyVm9XK1FERWRNQ21XUlFVSnVCRURHQ0U1UUpaT0dhemdD?=
 =?utf-8?B?SjU4RlZLTlVFWVpUZGRPWVVKdzdUY3ZkWlR4MVFTblQ2QWVjUHU4K1JseGZx?=
 =?utf-8?B?Qkd4UEZTNHlZcm1qdENyd1pidXo5TW1YdHFUaXlhWkVOTUFNdTExdmI4eTY3?=
 =?utf-8?B?amlGS2REbzBRZTB5MmltUTluYW82NVl1dXphU1grSEc4Zk4vN2JSNGtidy9G?=
 =?utf-8?B?SXd4T0JRMmZaSE0xdWw0RmlPLzFHQnhIWHZpYVVhcWVoZUhJZHNFb3FGRzZU?=
 =?utf-8?Q?Jk0hySVcAOs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b1d960-4c13-47fd-768d-08d994056af3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 20:08:44.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10/20/21 2:51 PM, Peter Zijlstra wrote:
> On Wed, Oct 20, 2021 at 08:12:51AM -0500, Tom Lendacky wrote:
>> On 10/15/21 4:44 AM, tip-bot2 for Tim Chen wrote:
>>> The following commit has been merged into the sched/core branch of tip:

> 
> If it does boot, what does something like:
> 
>    for i in /sys/devices/system/cpu/cpu*/topology/*{_id,_list}; do echo -n "${i}: " ; cat $i; done
> 
> produce?

The output is about 160K in size, I'll email it to you off-list.

> 
> I'll try and figure out how AMD sets l2c_id, that stuff is always a bit
> of a maze.

Thanks!

Tom

> 
